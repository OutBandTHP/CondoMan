Rails.application.routes.draw do
  root              'main_pages#home'
  get               '/help',   to: 'main_pages#help'
  get               '/about',  to: 'main_pages#about'
  get               '/login',  to: 'sessions#new'
  post              '/login',  to: 'sessions#create'
  delete            '/logout', to: 'sessions#destroy'
  resources         :projects,            only: [:index, :show, :create, :edit, :update, :new]
  resources         :configurates,        only: [:edit,  :update]
  resources         :select_project,      only: [:edit]
  resources         :years,               only: [:index, :edit, :update]
  resources         :select_year,         only: [:edit]
  resources         :users
  resources         :account_activations, only: [:edit]
  resources         :password_resets,     only: [:edit, :update, :new,  :create]
  resources         :buildings,           only: [:index, :show,  :edit, :update]
  resources         :units,               only: [:index, :show,  :edit, :update]
  resources         :notifications,       only: [:index, :show,  :edit, :update, :new, :create]
  resources         :trans_types,         only: [:index,         :edit, :update, :new, :create]
  resources         :books,               only: [:index,         :edit, :update, :new, :create]
  resources         :deploy_books,        only: [:index,         :edit, :update, :new, :create]
  resources         :suppliers,           only: [:index, :show, :create, :edit, :update, :new]
  resources         :transactions,        only: [:index, :show]
  
#  resources :transactions,                only: [:index, :show] do
#    match :in_onetime, via: [:get, :post], on: :member
#    match :in_cash,    via: [:get, :post], on: :member
#    match :in_bank,    via: [:get, :post], on: :member
#  end 
end