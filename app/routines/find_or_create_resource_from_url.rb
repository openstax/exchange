class FindOrCreateResourceFromUrl

  TRUSTED_HOSTS = [/\A[a-zA-Z0-9-]+\.openstax\.org\z/]

  lev_routine

  protected

  def to_absolute_uri(base_uri, uri)
    return uri if uri.absolute?

    uri = uri.dup

    uri.scheme = base_uri.scheme
    uri.host = base_uri.host

    uri
  end

  def is_trusted?(uri)
    TRUSTED_HOSTS.any? do |trusted_host|
      case trusted_host
      when Regexp
        uri.host =~ trusted_host
      else
        uri.host == trusted_host
      end
    end
  end

  def merge_resources(resources)
    return if resources.empty?

    chosen_resource = resources.first
    discarded_resources = resources[1..-1]

    discarded_resources.each do |resource|
      resource.links.each{ |link| link.update_attribute :resource, chosen_resource }

      resource.reload.destroy!
    end

    chosen_resource
  end

  def exec(url, options = {})

    uri = Addressable::URI.parse(url)

    fatal_error(code: :relative_url,
                message: 'Please provide absolute URLs',
                offending_inputs: [:url]) unless uri.absolute?

    fatal_error(code: :untrusted_host,
                message: 'The given URL belongs to an untrusted host',
                offending_inputs: [:url]) unless is_trusted?(uri)

    link = Link.find_by(href: uri.to_s)

    unless link.nil? # Return result from DB if available
      outputs[:resource] = link.resource
      return
    end

    # Use a HEAD request to see if we find more links to the resource
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request Net::HTTP::Head.new(uri)
    end

    new_links = {}

    link_args = (response['Link'] || '').split(',').map do |link|
      args = link.split(';').map(&:strip)
      href = args[0]
      split_args = args[1..-1].map{ |arg| arg.split('=') }
      rel = (split_args.find{ |arg| arg.first == 'rel' }.try(:second) || '').downcase
      [href, rel]
    end

    selected_links = link_args.select do |href, rel|
      rel.blank? || rel.include?('canonical') || rel.include?('alternate')
    end

    selected_links.each do |href, rel|
      is_canonical = rel.include? 'canonical'
      new_links[href] = [:link_header, is_canonical]
    end

    new_links[response['Location']] ||= [:location_header, false] \
      if response.code == '301' && response['Location'].present?

    # Search DB for more matches
    found_resources = Resource.preload(:links).joins(:links).where(links: { href: new_links.keys })

    # If more than one resource found, pick any one and change all found links to point to it
    # If no resources found, create a new resource
    outputs[:resource] = merge_resources(found_resources) || Resource.create!

    # Add the given URL to list of links to store in the DB
    new_links[uri.to_s] ||= [:other, false]

    # Store found links in the DB
    # Force all found links to point to the same resource
    new_links.each do |href, (source, is_canonical)|
      link = Link.find_or_initialize_by(href: href)
      link.resource = outputs[:resource]
      link.source = source
      link.is_canonical = is_canonical
      link.save!
    end

    outputs[:resource].links.reset
  end

end
