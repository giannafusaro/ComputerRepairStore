Rails.application.routes.draw do

  root 'site#home', as: :site

  get  '/login'  => 'site#home'
  post '/login'  => 'customers#login'

  get  '/signup' => 'site#home'
  post '/signup' => 'customers#signup'

  get  '/dashboard' => 'site#dashboard', as: :dashboard

  resources :repairs
  resources :customers
  resources :employees

  namespace :employee do
    post '/login' => 'employees#login', as: :login
    get '/dashboard' => 'site#dashboard', as: :dashboard
    resources :repairs
    resources :customers
    resources :employees
  end
end
