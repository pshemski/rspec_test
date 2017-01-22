class DeliveriesController < ApplicationController
  def login
  end

  def orders
    @orders = Order.all
  end

  def create
  	@delivery = Delivery.find_or_initialize_by(delivery_params)
    if @delivery.save
      log_in @delivery
      redirect_to delivery_orders_path(@delivery)
    else
      flash.now[:error] = "contact your administrator"
      render action: :login
    end
  end

  def show
    @delivery = Delivery.find(params[:id])
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def delivery_params
    params.require(:deliveries).permit(:name, :phone_number)
  end
end
