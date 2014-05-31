class IdentityAccessPolicy
  # Contains all the rules for which requestors can do what with which Identity objects.

  def self.action_allowed?(action, requestor, identity)
    # Deny access for human users
    return false unless requestor.is_application?

    # Create is currently the only available action
    [:create].include?(action)
  end

end
