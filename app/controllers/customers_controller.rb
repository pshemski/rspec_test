class CustomersController < ApplicationController
  def new
  	@customer = Customer.new
  end

  def create
  	@customer = Customer.new(customer_params)
    if @customer.save
      session[:customer_id] = @customer.id
      current_order.update_attribute(:customer_id, @customer.id)
      redirect_to new_confirmation_path
    end
  end

  private

  def customer_params
  	params.require(:customer).permit(:delivery_address, :email, :name, :postcode)
  end
end
