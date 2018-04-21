Rails.application.routes.draw do
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
  resources :user_machines, only: %i(index show)

  root 'home#show'
end
