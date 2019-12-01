Rails.application.routes.draw do
  root 'main_pages#home'
  get  '/help',    to: 'main_pages#help'
  get  '/admin',   to: 'main_pages#admin'
  get  '/about',   to: 'main_pages#about'
  resources        :projects
  resources        :users
end
