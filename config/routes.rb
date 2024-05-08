Rails.application.routes.draw do
  post '/admin/create_frame', to: 'admin#create_frame'
  post '/admin/create_lens', to: 'admin#create_lens'
  get '/user/active_frames', to: 'user#active_frames'
  get '/user/all_lenses', to: 'user#all_lenses'
  post '/user/create_glasses', to: 'user#create_glasses'

end
