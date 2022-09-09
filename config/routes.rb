Rails.application.routes.draw do
  resources :reccomendations

  root 'pages#home'
  
  post 'search/searchbar', to: 'search#searchbar'
  post 'search/spotify', to: 'search#spotify'
  
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }

  devise_for :modders, controllers: {
    sessions: 'modders/sessions',
    passwords: 'modders/passwords',
    registrations: 'modders/registrations'
  }

  #Routes per l'OAuth di Google
  get '/redirect', to: 'events#redirect', as: 'redirect'
  get '/callback', to: 'events#callback', as: 'callback'

  post '/events/:id/:calendar_id', to: 'events#new_googlecalendar_event', as: 'new_googlecalendar_event', calendar_id: /[^\/]+/
  delete '/events/:id/:calendar_id', to: 'events#delete_googlecalendar_event', as: 'delete_googlecalendar_event', calendar_id: /[^\/]+/

  get '/chats/index'
  get '/user/:uid', to: 'users#show'
  get '/user/:uid/edit', to: 'users#edit'
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

  resources :events

  resources :communities do
    resources :posts
    resources :events
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
  post '/chats/:user2_id',
       to: 'chats#create',
       as: 'create_chat'
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
  post '/users/:user_id/communities/:community_id/participations/move', to: 'participations#move',
                                                                        as: 'move_user_community_participation'
  get '/posts/:post_id/reactions/:id', to: 'reactions#update', as: 'update_post_reaction'
  get '/posts/:post_id/comments/:comment_id/comment_reactions/:id',
      to: 'comment_reactions#update',
      as: 'update_post_comment_comment_reaction'
end
