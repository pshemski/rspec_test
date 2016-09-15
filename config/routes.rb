Rails.application.routes.draw do

	get '/orders/:order_id/summary' => 'orders#summary', as: :order_summary
  post '/orders' => 'orders#create'
  patch '/orders/:id' => 'orders#update', as: :order
  put '/orders/:id' => 'orders#update'
  post '/customers' => 'customers#create'
  get '/customers/new' => 'customers#new', as: :new_customer
  post 'confirmations' => 'confirmations#create'
  get '/confirmations/new' => 'confirmations#new', as: :new_confirmation
  patch '/confirmations/:id' => 'confirmations#update', as: :confirmation
  put '/confirmations/:id' => 'confirmations#update'
  root 'home#index'
end
