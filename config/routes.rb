Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  resources :passwords, controller: "clearance/passwords", only: %i[create new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: %i[create show edit update] do
    resource :password,
             controller: "clearance/passwords",
             only: %i[edit update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  root to: 'users#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
