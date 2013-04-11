Exchange::Application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :identities, :except => [:new, :edit]
    end
  end
  
  resources :api_keys, :except => [:new, :edit]

  root :to => "static_page#home"

  match 'copyright', :to => 'static_page#copyright'
end
