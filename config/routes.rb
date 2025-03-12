Rails.application.routes.draw do
  root              'main_pages#home'
  get               '/help',   to: 'main_pages#help'
  get               '/about',  to: 'main_pages#about'
  get               '/login',  to: 'sessions#new'
  post              '/login',  to: 'sessions#create'
  delete            '/logout', to: 'sessions#destroy'
  resources         :projects, only: [:index, :show, :new, :create, :edit, :update]
  resources         :select_project, only: [:edit]
  resources         :users
  resources         :roles
  resources         :account_activations, only: [:edit]
  resources         :password_resets, only: [:new, :create, :edit, :update]
  resources         :buildings, only: [:index, :show, :edit, :update]
  resources         :units, only: [:index, :show, :edit, :update]
end
