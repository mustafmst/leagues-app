Rails.application.routes.draw do
    # Users routes
    resources :users
    get 'login', :to => 'users#get_login_form'
    post 'login', :to => 'users#login'
    get 'logout', :to => 'users#logout'
    get 'users/:id/editpassword', :to => 'users#edit_password', :as => 'edit_password'
    put 'users/:id/password', :to => 'users#update_password', :as => 'update_password'
    # Leagues routes
    get 'leagues', :to => 'leagues#index', :as => 'leagues'
    get 'leagues/new', :to => 'leagues#new', :as => 'new_league'
    post 'leagues', :to => 'leagues#create', :as => 'create_league'
    get 'leagues/:id', :to => 'leagues#show', :as => 'show_league'
    get 'leagues/:id/:user_id', :to => 'leagues#add_contestant', :as => 'add_contestant'
    # Other routes
    root "welcome#index"
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
