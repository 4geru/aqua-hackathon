Rails.application.routes.draw do
  get 'machines/index'
  get 'machines/result'
  get 'machines/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # for admin
  namespace :nyauth, path: :admin, as: :admin do
    # concerns :nyauth_registrable
    concerns :nyauth_authenticatable
    # concerns :nyauth_confirmable
  end

  # for user
  mount Nyauth::Engine => "/"
  resource :user, only: %i(edit update)
  resources :user_machines, only: %i(index create)
  get "user_machines/:shop_id/:machine_id" => "user_machines#show"
  get "user_machines/:shop_id/:machine_id/image" => "user_machines#image"  
  get "machines/:user_id/:shop_id/:machine_id" => "machines#show"
  resources :shops, only: %(show) do
    member do
      get 'outer_image'
      get 'inner_image'
    end
  end
  root 'home#show'
end
