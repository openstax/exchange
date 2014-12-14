RailsAdmin.config do |config|

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.authenticate_with do
    raise(SecurityTransgression) \
      if Rails.env.production? && current_administrator.nil?
  end

  config.current_user_method(&:current_account)

  config.included_models = ["OpenStax::Accounts::Account",
                            "Doorkeeper::Application",
                            "Administrator", "Agent", "Researcher",
                            "Platform", "Subscriber"]

  config.model "Doorkeeper::Application" do
    edit do
      field :name
      field :uid
      field :secret
      field :redirect_uri do
        help 'Required. Use urn:ietf:wg:oauth:2.0:oob for local tests.'
      end
      field :agents
    end
  end

  config.model "Administrator" do
    edit do
      field :account
    end
  end

  config.model "Agent" do
    edit do
      field :account
      field :application
    end
  end

  config.model "Researcher" do
    edit do
      field :account
    end
  end

  config.model "Platform" do
    edit do
      field :application
    end
  end

  config.model "Subscriber" do
    edit do
      field :application
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
