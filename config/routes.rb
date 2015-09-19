Rails.application.routes.draw do
  resources :urls, except: [:edit, :update, :destroy, :show]
  get ':short_address', to: 'urls#redirect'

  root 'urls#index'
end
