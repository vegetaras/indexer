Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'indexed_items#index'

  resources :indexed_items, only: %i[index create]
end
