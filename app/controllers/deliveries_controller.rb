class DeliveriesController < ApplicationController
  def login
	end

	def create
		@delivery = Delivery.new(delivery_params)
		@delivery.save
	end

	private

	def delivery_params
		params.require(:delivery).permit(:name, :phone_number)
	end
end
