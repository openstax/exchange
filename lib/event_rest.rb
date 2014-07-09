module EventRest
  protected

  def event_create(klass, represent_with = nil, &block)
    standard_create(klass, represent_with) do |event|
      event.platform = Platform.for(current_application)
      event.person_id = doorkeeper_token.resource_owner_id
      event.resource = Resource.find_or_create(event.platform, params[:resource])
      block.call(event) if block
    end
  end

end
