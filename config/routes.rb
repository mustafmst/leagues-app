Rails.application.routes.draw do
  resources :users
  get 'login', :to => 'users#get_login_form'
  post 'login', :to => 'users#login'
  get 'logout', :to => 'users#logout'
  root "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
