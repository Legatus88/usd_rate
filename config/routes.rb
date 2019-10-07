Rails.application.routes.draw do
  root "rateroom#index"

  get 'admin', to: 'rateroom#admin'

  mount ActionCable.server, at: '/cable'
end
