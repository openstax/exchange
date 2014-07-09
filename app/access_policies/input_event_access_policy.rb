class InputEventAccessPolicy
  # Contains all the rules for which requestors can do what with which InputEvent objects.

  def self.action_allowed?(action, requestor, input_event)
    # Any flow

    # The only action on these InputEvents is create
    action == :create
  end

end
