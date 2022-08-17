Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :salon_infos
  resources :appointments
  get 'get_salon_services' => 'salon_infos#get_salon_services'
end
