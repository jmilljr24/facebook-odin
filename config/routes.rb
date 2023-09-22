Rails.application.routes.draw do
  resources :posts do
    resources :likes
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'posts#index'

  devise_for :users,
             controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
end
