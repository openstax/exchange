class IdentifierAccessPolicy
  # Contains all the rules for which requestors can do what with which Identifier objects.

  def self.action_allowed?(action, requestor, user)
    # Client Credentials flow
    return false unless requestor.is_a? Doorkeeper::Application

    # The only action on Identifier is create
    action == :create
  end

end
