class CustomersController < ApplicationController
  def new
  	@customer = Customer.new
  end

  def create
  	@customer = Customer.new(customer_params)
  	if @customer.save
  	else
  	end
  end

  private

  def customer_params
  	params.require(:customer).permit(:name, :email, :delivery_address, :postcode)
  end
end