Exchange::Application.routes.draw do

  # Root

  root :to => "static_pages#home"

  # Status

  get :status, to: lambda { head :ok }

  # Gems

  use_doorkeeper

  mount OpenStax::Accounts::Engine, at: "/accounts"
  mount FinePrint::Engine, at: "/fine_print"

  # Developer

  namespace 'dev' do
    resources :users, only: [:create] do
      post 'generate', on: :collection
    end
  end

  # Admin

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

    resources :users, only: [:show, :edit, :update, :destroy]

    resources :accounts, only: [:index] do
      post 'become', on: :member
      post 'index', on: :collection
    end
  end

  # JSON API

  apipie

  api :v1, :default => true do
  end

  # HTML Pages

  # Resources

  resources :terms, only: [:index, :show] do
    collection do
      get 'pose'
      post 'agree', as: 'agree_to'
    end
  end

  # Singular routes
  # Only for routes with unique names

  resource :user, only: [], path: '', as: '' do
    get 'registration'
    put 'register'
  end

  resource :static_page, only: [], path: '', as: '' do
    get 'api'
    get 'copyright'
    get 'about'
  end

end
