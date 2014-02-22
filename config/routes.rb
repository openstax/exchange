Exchange::Application.routes.draw do
  
  mount OpenStax::Connect::Engine, at: "/connect"

  use_doorkeeper

  apipie

  namespace 'dev' do
    get "/", to: 'base#index'

    namespace 'users' do
      post 'search'
      post 'create'
      post 'generate'
    end
  end

  namespace 'admin' do
    get '/', to: 'base#index'

    put "cron",                         to: 'base#cron', :as => "cron"
    get "raise_security_transgression", to: 'base#raise_security_transgression'
    get "raise_record_not_found",       to: 'base#raise_record_not_found'
    get "raise_routing_error",          to: 'base#raise_routing_error'
    get "raise_unknown_controller",     to: 'base#raise_unknown_controller'
    get "raise_unknown_action",         to: 'base#raise_unknown_action'
    get "raise_missing_template",       to: 'base#raise_missing_template'
    get "raise_not_yet_implemented",    to: 'base#raise_not_yet_implemented'
    get "raise_illegal_argument",       to: 'base#raise_illegal_argument'

    resources :users, only: [:show, :update, :edit] do
      post 'search', on: :collection
    end
  end

  namespace :api do
    namespace :v1 do
      resources :identities, :only => [:create]
    end
  end
  
  resources :api_keys, :except => [:new, :edit, :update]

  root :to => "static_page#home"

  match 'copyright', :to => 'static_page#copyright'
  match 'api', :to => 'static_page#api'
  match 'status', to: 'utility#status'
  match 'about', to: 'static_page#about'
end
