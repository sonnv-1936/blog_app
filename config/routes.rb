Rails.application.routes.draw do
  resources :entries, param: :entry_id
  resources :users, param: :user_id, except: %i(index) do
    member do
      get :following_entries
    end
  end
  resource :session, only: %i(new create destroy)
  resources :comments, param: :comment_id, only: %i(create destroy)
  resources :relationships, only: %i(create destroy)
  resources :admins, only: :index

  root "entries#index"
end
