ActionInterceptor.configure do
  # intercepted_url_key(key)
  # Type: Method
  # Arguments: key (Symbol)
  # The parameter/session variable that will hold the intercepted URL.
  # Default: :r
  intercepted_url_key :return_to

  # override_url_options(bool)
  # Type: Method
  # Arguments: bool (Boolean)
  # If true, the url_options method will be overriden for any controller that
  # `acts_as_interceptor`. This option causes all links and redirects from any
  # such controller to include a parameter containing the intercepted_url_key
  # and the intercepted url. Set to false to disable for all controllers.
  # If set to false, you must use the interceptor_url_options method to obtain
  # the hash and pass it to any links or redirects that need to use it.
  # Default: true
  override_url_options true

  # interceptor(interceptor_name, &block)
  # Type: Method
  # Arguments: interceptor name (Symbol or String),
  #            &block (Proc)
  # Defines an interceptor.
  # Default: none
  # Example: interceptor :my_name do
  #            redirect_to my_action_users_url if some_condition
  #          end
  #
  #          (Conditionally redirects to :my_action in UsersController)
  interceptor :registration do
    # For API controllers
    user = (request.format == :json) ? current_human_user : current_user

    # Don't ask users to register if they have already or before they login
    return unless user && !user.is_anonymous? && !user.is_registered?

    respond_to do |format|
      format.html { redirect_to registration_path }
      format.json { head(:forbidden) }
    end
  end
end
