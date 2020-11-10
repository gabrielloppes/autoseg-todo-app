Rails.application.routes.draw do
  resources :todo_lists do
    resources :todo_items
  end
  
  devise_for :users
  root to: "todo_lists#index"
end
