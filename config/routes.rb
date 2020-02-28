Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/login', to: 'sessions#create'
      post '/signup', to: 'users#create'
      get '/current_user', to: 'sessions#show'
      get '/user/:id/conversations', to: 'conversations#index'
      get '/conversation/:id/messages', to: 'conversations#show'
      post '/logout', to: 'sessions#logout'
      post '/new_notifications', to: 'sessions#new_notifications'
      post '/cancel_conversation', to: 'conversations#cancel_new_conversation'
      post '/messages', to: 'messages#create'
      post '/messages_from_modal', to: 'messages#create_from_modal'
      post '/conversations', to: 'conversations#create'
      post '/conversation/view', to: 'conversations#view'
      get '/search/users/:query', to: 'users#search'
      get '/search/users/exact/:query', to: 'users#exact_search'
      post '/search/users/email/', to: 'users#email_search', constraints: { sender: /[^\/]+/}
      put '/conversation/:conversation_id/remove_user/:user_id', to: 'conversations#remove_user'
      post '/upload_pic' , to: 'photos#upload_pic'
      post '/upload_pic_private' , to: 'photos#upload_pic_private'
      post '/get_photos' , to: 'photos#index_photo'
      post '/get_photos_private' , to: 'photos#index_photo_private'
      post '/delete_photo' , to: 'photos#delete_photo'
      post '/get_user_details', to: 'user_details#get_details'
      post '/update_details', to: 'user_details#update_details'
      post '/get_members', to: 'users#get_members'
      post '/update_photo_primary', to: 'photos#make_primary'
      post '/update_min_age', to: "users#update_min_age"
      post '/update_max_age', to: "users#update_max_age"
      post '/create_smiley', to: 'smileys#create_smiley'
      post '/sent_smileys', to: 'smileys#sent_smileys'
      post '/get_favorites', to: 'favorites#get_favorites'
      post '/create_favorite', to: 'favorites#add_favorite'
      post '/remove_favorite', to: 'favorites#remove_favorite'
      post '/check_conversation', to: 'conversations#check_conversation'
      post 'create_visit', to: 'visitors#create_visit'
      post 'favorites_list', to: "favorites#get_favorites"
      post '/visitors_list', to: "visitors#index"
      post '/smilers_list', to: "smileys#smilers_list"
      post '/crop_photo', to: 'photos#crop_photo'
      post 'new_block', to: 'blockeds#create'
      post 'new_block_convo',  to: 'blockeds#create_convo'
      post '/password/forgot', to: 'passwords#forgot'
      post '/password/reset', to: 'passwords#reset'
      put '/password/update', to: 'passwords#update'
      post '/check_password', to: 'passwords#check'
      post '/reset_password', to: 'passwords#reset_password'
      post '/email_update', to: 'passwords#email_update'
      post '/email_send_token', to: 'passwords#email_send_token'
      post 'deactivate_account', to: 'users#deactivate_account'
      post 'update_age', to: 'users#update_age'
      get '/fake_users', to: 'users#fakes_list'
      post '/get_user_infos', to: 'users#get_user_infos'
      get '/update_online_status', to: 'users#update_online_status'
      get 'logout', to: 'users#logout'
      post '/search_online_members', to: 'users#filter_online'
      post '/search_photos_members', to: 'users#filter_photos'
      post '/update_distance', to: 'users#update_distance'
      post '/check_activation_code', to: 'users#check_activation_code'
      mount ActionCable.server => '/cable'
    end
  end   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
