Rails.application.routes.draw do
  resources :entries, only: %i(new create)
  resources :users, param: :user_id, except: %i(index edit update)
  resource :session, only: %i(new create destroy)

  root "entries#index"
end
