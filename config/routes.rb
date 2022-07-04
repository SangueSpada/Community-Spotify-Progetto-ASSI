Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users, :controllers => { 
    :omniauth_callbacks => "users/omniauth_callbacks",
    :sessions => "users/sessions" 
  }

  get "/user/:uid", to: "users#show"
  post '/users/:uid/follow', to: "users#follow", as: "follow_user"
  post '/users/:uid/unfollow', to: "users#unfollow", as: "unfollow_user"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :posts do
    resources :comments, only: [:create,:update,:destroy] do
      resources :comment_reactions#, only: [:create,:update,:destroy]
    end
    resources :reactions, only: [:create,:update,:destroy]
  end
  
  resources :communities do
    resources :community_posts do
      resources :comments, only: [:create,:update,:destroy] do
        resources :comment_reactions, only: [:create,:update,:destroy]
      end
      resources :reactions, only: [:create,:update,:destroy]
    end
  end

  resources :tags
end
