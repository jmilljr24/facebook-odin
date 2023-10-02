Rails.application.routes.draw do
  get 'comment/new'
  get 'comment/create'
  get 'users/index'
  get 'users/show'
  get 'friendships/create'
  get '/saw_notification', to: 'users#saw_notification', as: 'saw_notice'
  post '/post/comment/create', to: 'comments#create', as: 'comment_comments'

  post 'like/:id', to: 'posts#like', as: 'like_post'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'posts#index'

  devise_for :users,
             controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: %i[index show] do
    resources :friendships, only: %i[create] do
      collection do
        get 'accept_friend'
        get 'decline_friend'
      end
    end
  end
  resources :posts do
    resources :likes
  end

  resources :comments, only: %i[new create destroy] do
    resources :likes, only: %i[create]
  end
end
