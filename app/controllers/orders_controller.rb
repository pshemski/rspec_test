class OrdersController < ApplicationController
  def summary
    @orders = Order.all
  end

  def create
  	@order = Order.new(order_params.merge(state: State.pending))
  	if @order.save
  		new_order @order
      redirect_to new_customer_path
  	else
  		redirect_to root_path
  	end
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(order_params)
      flash[:notice] = "Order has been updated!"
      if @order.state == State.assigned
        redirect_to delivery_path(current_delivery)
      else
        redirect_to :back
      end
    else
      flash[:error] = "Something went wrong"
      redirect_to :back
    end
  end

  private

  def order_params
  	params.require(:order).permit(:weight_in_kg,
      :quantity,
      :preffered_time,
      :notes,
      :payment_amount_in_cents,
      :brand_id,
      :state_id,
      :delivery_id)
	end
end

