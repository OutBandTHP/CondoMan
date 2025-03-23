Rails.application.routes.draw do
  root              'main_pages#home'
  get               '/help',   to: 'main_pages#help'
  get               '/about',  to: 'main_pages#about'
  get               '/login',  to: 'sessions#new'
  post              '/login',  to: 'sessions#create'
  delete            '/logout', to: 'sessions#destroy'
  resources         :projects,            only: [:index, :show, :create, :edit, :update, :new]
  resources         :select_project,      only: [:edit]
  resources         :users
  resources         :account_activations, only: [:edit]
  resources         :password_resets,     only: [:edit, :update, :new, :create]
  resources         :buildings,           only: [:index, :show, :edit, :update]
  resources         :units,               only: [:index, :show, :edit, :update]
  resources         :notifications,       only: [:index, :show, :edit, :update, :new, :create]
end