Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "refrigeration_time#index"
  get "/getOutTime", to: "refrigeration_time#getOutTime", as: :get_out_time
  post "/UpdateOutTime", to: "refrigeration_time#updateOutTime", as: :update_out_time
end
