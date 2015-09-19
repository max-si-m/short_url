Rails.application.routes.draw do
  resources :urls, except: [:edit, :update, :destroy]
end
