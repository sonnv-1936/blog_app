Rails.application.routes.draw do
  resources :entries, param: :entry_id, only: %i(new create show)
  resources :users, param: :user_id, except: %i(index edit update)
  resource :session, only: %i(new create destroy)
  resources :comments, only: :create
  resources :relationships, only: %i(create destroy)

  root "entries#index"
end
