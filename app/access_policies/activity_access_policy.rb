class ActivityAccessPolicy
  # Contains all the rules for which requestors can do what with which Activity objects.

  def self.action_allowed?(action, requestor, user)
    # Client Credentials flow
    return false unless requestor.is_a? Doorkeeper::Application

    # The only action on Activity is index
    action == :index
  end

end
