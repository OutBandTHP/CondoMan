Rails.application.routes.draw do
  root              'main_pages#home'
  get               '/help',   to: 'main_pages#help'
  get               '/about',  to: 'main_pages#about'
  get               '/login',  to: 'sessions#new'
  post              '/login',  to: 'sessions#create'
  delete            '/logout', to: 'sessions#destroy'
  resources         :projects, only: [:index, :show, :new, :create, :edit, :update]
  resources         :users
  resources         :account_activations, only: [:edit]
  resources         :password_resets, only: [:new, :create, :edit, :update]
  resources         :buildings, only: [:show, :edit, :update]
end
