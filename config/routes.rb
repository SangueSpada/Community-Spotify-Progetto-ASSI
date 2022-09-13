Rails.application.routes.draw do
  resources :reccomendation
  resources :user_reccomendations
  resources :community_reccomendations

  root 'pages#home'
  
  get '/reccomendations', to: 'pages#reccomendations'
  
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
  get '/redirect', to: 'event_participations#redirect', as: 'redirect'
  get '/callback', to: 'event_participations#callback', as: 'callback'

  post '/events/:id/:calendar_id', to: 'event_participations#create', as: 'new_googlecalendar_event', calendar_id: /[^\/]+/
  delete '/events/:id/:calendar_id', to: 'event_participations#destroy', as: 'delete_googlecalendar_event', calendar_id: /[^\/]+/

  get '/chats/index'
  get '/users/:uid', to: 'users#show', as: 'uid_user'
  get '/users/:uid/edit', to: 'users#edit', as: 'edit_user'
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

  resources :events do
    resources :users do
      resources :event_participations
    end
  end

  resources :communities do
    resources :posts
    resources :events
  end
  post '/communities/:id/add_playlist', to: 'communities#add_playlist', as: 'community_add_playlist'
  post '/communities/:id/remove_playlist', to: 'communities#remove_playlist',as:'community_remove_playlist'

  resources :users do

    resources :communities do
      resources :participations
    end

    resources :events do
      resources :event_participations
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
