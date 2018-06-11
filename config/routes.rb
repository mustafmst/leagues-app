Rails.application.routes.draw do
    resources :users
    get 'login', :to => 'users#get_login_form'
    post 'login', :to => 'users#login'
    get 'logout', :to => 'users#logout'
    get 'leagues', :to => 'leagues#index', :as => 'leagues'
    get 'users/:id/editpassword', :to => 'users#edit_password', :as => 'edit_password'
    put 'users/:id/password', :to => 'users#update_password', :as => 'update_password'
    root "welcome#index"
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
