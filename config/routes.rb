Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users, :controllers => { 
    :omniauth_callbacks => "users/omniauth_callbacks",
    :sessions => "users/sessions" 
  }

  get "/user/:uid", to: "users#show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :posts do
    resources :comments do
      resources :comment_reactions
    end
    resources :reactions
  end
  
  resources :communities do
    resources :community_posts do
      resources :comments do
        resources :reactions
      end
      resources :comment_reactions
    end
  end
end
