class ActivityAccessPolicy
  # Contains all the rules for which requestors can do what with which Activity objects.

  def self.action_allowed?(action, requestor, activity)
    # TBD
    return false

    # The only action on Activity is index
    action == :index
  end

end
