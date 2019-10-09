Rails.application.routes.draw do
  root 'rateroom#index'

  resources :timers, except: [:new]
  get 'admin', to: 'timers#new'

  mount ActionCable.server, at: '/cable'
end
