Rails.application.routes.draw do
  root   'main_pages#home'
  get    '/help',   to: 'main_pages#help'
  get    '/about',  to: 'main_pages#about'
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources         :projects
  resources         :users
end
