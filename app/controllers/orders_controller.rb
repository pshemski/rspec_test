class OrdersController < ApplicationController

	def summary
	end

  def create
  	@order = Order.new(order_params)
  	if @order.save
  		session[:order_id] = @order.id
      redirect_to new_customer_path
  	end
  end

  def update
  end

  private

  def order_params
  	params.require(:order).permit(:state_id, :brand_id, :weight_in_kg, :quantity, :preferred_time, :notes, :payment_amount_in_cents)
  end
end
