Rails.application.routes.draw do
  resources :entries, only: %i(new create)
  resources :users, param: :user_id

  root "entries#index"
end
