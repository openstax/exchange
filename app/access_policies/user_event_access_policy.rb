class UserEventAccessPolicy
  # Contains all the rules for which requestors can do what with which Event objects,
  # for events meant to be created by users.

  def self.action_allowed?(action, requestor, user_event)
    # (Implicit) Authorization flow
    return false unless requestor.is_a? Identifier

    # The only action on these Events is create
    action == :create && requestor == user_event.task.identifier
  end

end
