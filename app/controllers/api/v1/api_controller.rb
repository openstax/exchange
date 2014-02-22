module Api
  module V1
    class ApiController < ApplicationController     
      include Roar::Rails::ControllerAdditions

      # This skips the normal user login we inherit from the application controller,
      # not appropriate for API use
      skip_before_filter :authenticate_user!

      # For the moment, freak out if the user is anonymous (restrict access to
      # known users that have signed API terms of use, etc)
      before_filter :no_anonymous_users!
      
      respond_to :json

      rescue_from Exception, :with => :rescue_from_exception

      # TODO need a separate mechanism to get users of the API (the people who manage
      # applications that use the API) to sign API terms of use after a change.  For
      # non-API users of the site, we require immediate agreement to terms changes, but
      # that isn't reasonable for API users -- they will expect the API to continue
      # working for their application and must be given a reasonable amount of time (at 
      # least 30 days) to come to the site to agree to the updates.  And we should send
      # email reminders to get them to come.
      
      def current_user
        @current_user ||= doorkeeper_token ? 
                          User.find(doorkeeper_token.resource_owner_id) : 
                          super
      end

    protected

      def no_anonymous_users!
        raise SecurityTransgression if current_user.is_anonymous?
      end

      def rescue_from_exception(exception)
        # See https://github.com/rack/rack/blob/master/lib/rack/utils.rb#L453 for error names/symbols

        error = :internal_server_error
        send_email = true
    
        case exception
        when SecurityTransgression
          error = :forbidden
          send_email = false
        when ActiveRecord::RecordNotFound, 
             ActionController::RoutingError,
             ActionController::UnknownController,
             AbstractController::ActionNotFound
          error = :not_found
          send_email = false
        end

        ExceptionNotifier::Notifier.exception_notification(
          request.env,
          exception,
          :data => {:message => "An exception occurred"}
        ).deliver if send_email

        Rails.logger.debug("An exception occurred: #{exception.inspect}") if Rails.env.development?

        head error
      end

    end

   
  end
end