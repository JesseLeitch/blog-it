Rails.application.routes.draw do
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => "users#new", :as => "sign_up"
  root :to => "articles#index"
  resources :users
  resources :sessions
  resources :articles
  resources :comments
  resources :articles do
    get 'page/:page', :action => :index, :on => :collection
  end
end