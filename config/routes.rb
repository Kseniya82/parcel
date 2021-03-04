Rails.application.routes.draw do
  get '/file/new', action: :new, controller: 'file'
  post '/file/upload', action: :upload, controller: 'file'
  root to: '/upload/new', action: :new, controller: 'file'
end
