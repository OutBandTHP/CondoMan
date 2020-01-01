Rails.application.routes.draw do
  root   'main_pages#home'
  get    '/help',   to: 'main_pages#help'
  get    '/about',  to: 'main_pages#about'
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources         :projects, only: [:show, :new, :create, :edit, :update]
  resources         :users
  resources         :buildings, only: [:show, :edit, :update]
end
