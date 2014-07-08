class IdentifierAccessPolicy
  # Contains all the rules for which requestors can do what with which Identifier objects.

  def self.action_allowed?(action, requestor, identifier)
    # Client Credentials flow
    return false unless requestor.is_a?(Doorkeeper::Application) &&\
                        Platform.for(requestor)

    # The only action on Identifier is create
    action == :create && identifier.application == requestor
  end

end
