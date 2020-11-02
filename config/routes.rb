Rails.application.routes.draw do
<<<<<<< HEAD
  get 'home/login'
  get 'home/signup'
=======
  resources :secure_passwords
  devise_for :users
  root to: "home#index"

  get '/dashboard/index'
>>>>>>> master
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
