class ActivityAccessPolicy
  # Contains all the rules for which requestors can do what with which
  # Activity objects.

  def self.action_allowed?(action, requestor, activity)
    # The only action on Activity is search
    case action
    when :search
      case requestor
      when Doorkeeper::Application
        !requestor.subscriber.nil?
      when OpenStax::Accounts::Account
        Researcher.where(account_id: requestor.id).exists?
      else
        false
      end
    else
      false
    end
  end

end
