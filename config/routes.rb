Rails.application.routes.draw do
  root 'pages#home'

  namespace :episodes do
    get 'random'
    post 'query'
  end
end
