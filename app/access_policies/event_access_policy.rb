class EventAccessPolicy
  # Contains all the rules for which requestors can do what with which Event objects.

  def self.action_allowed?(action, requestor, event)
    # Client Credentials flow
    return false unless requestor.is_a? Doorkeeper::Application

    # The only action on Event is index
    action == :index
  end

end
