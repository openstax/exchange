class PersonAccessPolicy
  # Contains all the rules for which requestors can do what with which Person objects.

  def self.action_allowed?(action, requestor, person)
    # Client Credentials flow
    return false unless requestor.is_a?(Doorkeeper::Application) &&\
                        !requestor.platform.nil?

    # The only action on Person is create
    action == :create && \
    person.identifiers.any?{ |i|i.application == requestor}
  end

end
