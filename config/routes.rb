Rails.application.routes.draw do
  post 'search', to: 'search#index'
  root 'pages#home'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }
  get '/chats/index'
  get '/user/:uid', to: 'users#show'
  post '/users/:uid/follow', to: 'users#follow', as: 'follow_user'
  post '/users/:uid/unfollow', to: 'users#unfollow', as: 'unfollow_user'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :posts do
    resources :comments do
      resources :comment_reactions, only: %i[create update destroy]
    end
    resources :reactions, only: %i[create update destroy]
  end

  resources :communities do
    resources :posts
  end

  resources :users do
    resources :communities do
      resources :participations
    end
  end

  resources :tags

  resources :chats do
    resources :messages
  end

  post '/users/:user_id/communities/:community_id/participations/create',
       to: 'participations#create',
       as: 'create_user_community_participation'
  post '/users/:user_id/communities/:community_id/participations/ban',
       to: 'participations#ban',
       as: 'ban_user_community_participation'
  post '/users/:user_id/communities/:community_id/participations/unban',
       to: 'participations#unban',
       as: 'unban_user_community_participation'
  post '/users/:user_id/communities/:community_id/participations/promote',
       to: 'participations#promote',
       as: 'promote_user_community_participation'
  post '/users/:user_id/communities/:community_id/participations/demote',
       to: 'participations#demote',
       as: 'demote_user_community_participation'
  get '/posts/:post_id/reactions/:id', to: 'reactions#update', as: 'update_post_reaction'
  get '/posts/:post_id/comments/:comment_id/comment_reactions/:id',
      to: 'comment_reactions#update',
      as: 'update_post_comment_comment_reaction'
end
