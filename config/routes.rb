Exchange::Application.routes.draw do
  resources :api_keys

  root :to => "static_page#home"

  match 'copyright', :to => 'static_page#copyright'
end
