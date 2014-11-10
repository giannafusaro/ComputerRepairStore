Rails.application.routes.draw do

  root 'site#home', as: :site

  get  '/login'  => 'site#home'
  post '/login'  => 'customers#login'

  get '/logout' => 'customers#logout'

  get  '/signup' => 'site#home'
  post '/signup' => 'customers#signup'

  get  '/dashboard' => 'site#dashboard', as: :dashboard

  resources :repairs
  resources :customers

  namespace :employee do
    get '/' => 'site#home', as: :site

    get '/login' => 'site#home'
    post '/login' => 'employees#login'

    get '/logout' => 'customers#logout'

    get '/take_ownership/:id' => 'employees#take_ownership', as: :take_ownership

    resources :repairs

    get '/dashboard' => 'site#dashboard', as: :dashboard

  end
end
