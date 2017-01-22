Rails.application.routes.draw do
  
	root 'home#index'
  resources :orders, only: [:create, :update, :show] do
  	get 'summary' => 'orders#summary'
  end

	resources :customers, only: [:new, :create]
	resources :confirmations, only: [:new, :create, :update]
	get 'deliveries/login' => 'deliveries#login', as: 'login_deliveries'
  get 'deliveries' => redirect('deliveries/login', status: 301)
  resources :deliveries, only: [:create, :show, :destroy] do
  	get 'orders' => 'deliveries#orders'
  end

end
