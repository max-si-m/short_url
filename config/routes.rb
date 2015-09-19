Rails.application.routes.draw do
  resources :urls, except: [:edit, :update, :destroy, :show]
  root 'urls#index'
end
