module ControllerExtensions
  def self.included(base)
    base.class_exec do
      protect_from_forgery

      layout "layouts/application_body_only"

      protect_beta username: SECRET_SETTINGS[:beta_username], 
                   password: SECRET_SETTINGS[:beta_password]

      fine_print_get_signatures :general_terms_of_use, :privacy_policy

      rescue_from Exception, :with => :rescue_from_exception

      helper_method :current_account

      protected

      def current_administrator
        Administrator.where(:account_id => current_account.id).first
      end

      def current_agent
        Agent.where(:account_id => current_account.id).first
      end

      def current_researcher
        Researcher.where(:account_id => current_account.id).first
      end

      def authenticate_administrator!
        current_administrator || raise(SecurityTransgression)
      end

      def authenticate_agent!
        current_agent || raise(SecurityTransgression)
      end

      def authenticate_researcher!
        current_researcher || raise(SecurityTransgression)
      end

      def rescue_from_exception(exception)
        # See https://github.com/rack/rack/blob/master/lib/rack/utils.rb#L453 for error names/symbols
        error, notify = case exception
        when SecurityTransgression
          [:forbidden, false]
        when ActiveRecord::RecordNotFound, 
             ActionController::RoutingError,
             ActionController::UnknownController,
             AbstractController::ActionNotFound
          [:not_found, false]
        else
          [:internal_server_error, true]
        end

        if notify
          ExceptionNotifier.notify_exception(
            exception,
            env: request.env,
            data: { message: "An exception occurred" }
          )

          Rails.logger.error("An exception occurred: #{exception.message}\n\n#{exception.backtrace.join("\n")}")
        end

        raise exception if Rails.application.config.consider_all_requests_local
        head error
      end
    end
  end
end

ActionController::Base.send :include, ControllerExtensions
