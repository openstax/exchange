class CreateIdentifier

  lev_routine

  protected

  def exec(platform, options={}, &block)

    person = Person.new

    identifier = Identifier.new(
      person: person,
      platform: platform
    )
    identifier.read_access_token = Doorkeeper::AccessToken.new(
      application: platform.try(:application),
      resource_owner: identifier,
      scopes: :read
    )
    identifier.write_access_token = Doorkeeper::AccessToken.new(
      application: platform.try(:application),
      resource_owner: identifier,
      scopes: :write
    )

    block.call(identifier) unless block.nil?

    identifier.save

    outputs[:identifier] = identifier
    transfer_errors_from identifier, { type: :verbatim }

  end
end
