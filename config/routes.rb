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
  get '/deliveries/:delivery_id/orders' => 'deliveries#orders'
  get '/deliveries' => redirect('deliveries/login', status: 301)
  get '/deliveries/login' => 'deliveries#login', as: :login_deliveries
  post '/deliveries' => 'deliveries#create'
  root 'home#index'
end
