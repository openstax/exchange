class InputEventAccessPolicy
  # Contains all the rules for which requestors can do what with which InputEvent objects.

  def self.action_allowed?(action, requestor, input_event)
    # Any flow
    return false unless (requestor.is_a? Person ||\
                         (requestor.is_a? Doorkeeper::Application &&\
                          Platform.for(requestor)))

    # The only action on these InputEvents is create
    action == :create && (requestor == input_event.person || \
                          Platform.for(requestor) == input_event.platform)
  end

end
