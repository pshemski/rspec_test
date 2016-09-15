Rails.application.routes.draw do
	get '/orders/:order_id/summary' => 'orders#summary', as: :order_summary
  post '/orders' => 'orders#create'
  patch '/orders/:id' => 'orders#udate', as: :order
  put '/orders/:id' => 'orders#udate'
  
end
