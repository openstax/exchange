class IdentifierAccessPolicy
  # Contains all the rules for which requestors can do what with which Identifier objects.

  def self.action_allowed?(action, requestor, identifier)
    # Client Credentials flow
    return false unless requestor.is_a?(Doorkeeper::Application) && !requestor.platform.nil?

    # The only action on Person is create
    action == :create && identifier.platform.application == requestor
  end

end
