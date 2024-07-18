Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check
  get 'arrivals/:stop_point_id', to: 'arrivals#show', as: :arrivals

  root 'arrivals#index'
end
