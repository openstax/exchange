Exchange::Application.routes.draw do

  # Root

  root :to => "static_pages#home"

  # Status

  get :status, to: lambda { head :ok }

  # Gems

  use_doorkeeper do
    skip_controllers :applications
  end

  mount OpenStax::Accounts::Engine, at: "/accounts"
  mount FinePrint::Engine, at: "/fine_print"

  # Administrator

  namespace 'admin' do
    get '/', to: 'base#index'

    put 'cron',                         to: 'base#cron', :as => 'cron'
    get 'raise_security_transgression', to: 'base#raise_security_transgression'
    get 'raise_record_not_found',       to: 'base#raise_record_not_found'
    get 'raise_routing_error',          to: 'base#raise_routing_error'
    get 'raise_unknown_controller',     to: 'base#raise_unknown_controller'
    get 'raise_unknown_action',         to: 'base#raise_unknown_action'
    get 'raise_missing_template',       to: 'base#raise_missing_template'
    get 'raise_not_yet_implemented',    to: 'base#raise_not_yet_implemented'
    get 'raise_illegal_argument',       to: 'base#raise_illegal_argument'

    user_crud :administrators
    user_crud :researchers

    resources :accounts, only: [:index] do
      post 'become', on: :member
    end

    resources :platforms do
      user_crud :agents
    end

    resources :subscribers do
      user_crud :agents
    end
  end

  # Agent

  namespace 'manage' do
    get '/', to: 'base#index'

    user_crud :agents
  end

  # Researcher

  namespace 'research' do
    get '/', to: 'base#index'
  end

  # JSON API

  apipie

  api :v1, :default => true do
  end

  # Shared Pages

  # Resources

  resources :terms, only: [:index, :show] do
    collection do
      get 'pose'
      post 'agree'
    end
  end

  # Singular routes
  # Only for routes with unique names

  resource :static_page, only: [], path: '', as: '' do
    get 'api'
    get 'copyright'
    get 'about'
  end

end
