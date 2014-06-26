class UserEventAccessPolicy
  # Contains all the rules for which requestors can do what with which Event objects,
  # for events meant to be created by users.

  def self.action_allowed?(action, requestor, user)
    # Implicit flow
    return false if requestor.is_a? Doorkeeper::Application

    # The only action on these Events is create
    action == :create
  end

end
