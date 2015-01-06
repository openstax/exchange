require 'open-uri'
require 'open_uri_redirections'

class FindOrCreateResourceFromUrl

  TRUSTED_HOSTS = ['www.example.org', 'exercises.openstax.org']
  INCLUDED_RELS = ['alternate', 'canonical']

  lev_routine

  protected

  def to_absolute_url(base, url)
    u = URI(url)

    unless u.absolute?
      b = URI(base)
      u.scheme = b.scheme
      u.host = b.host
    end

    u.to_s
  end

  def exec(url, options={})

    fatal_error(code: :relative_url,
                message: 'Please provide absolute URLs',
                offending_inputs: [:url]) unless URI(url).absolute?

    fatal_error(code: :untrusted_host,
                message: 'The given URL belongs to an untrusted host',
                offending_inputs: [:url]) \
      unless TRUSTED_HOSTS.include?(URI(url).host)

    current_link = Link.find_by(href: url)
    resource = current_link.try :resource

    if current_link.nil? # Resource URL not found in DB

      # Visit URL and get all the <link> tags inside <head>
      link_tags = Nokogiri::HTML(open(url, allow_redirections: :safe)) \
                    .xpath('//head//link')

      # Collect all <link> tags into a hash
      links = {}
      link_tags.each do |link_tag|
        rel = link_tag['rel']
        # Skip non-included rels
        next unless INCLUDED_RELS.include?(rel)

        href = to_absolute_url(url, link_tag['href'])
        links[href] ||= []
        links[href] << rel
      end

      # Search DB for a match
      resource = Link.where(href: links.keys).first.try :resource

      # Create new resource if no match
      resource ||= Resource.new

      # Add current URL to hash
      links[url] = ['alternate'] if links[url].blank?

      links.each do |href, rels|
        rels.each do |rel|
          link = Link.find_or_initialize_by(href: href, rel: rel)
          link.resource = resource
          link.save!
        end
      end
    end

    outputs[:resource] = resource

  end
end
