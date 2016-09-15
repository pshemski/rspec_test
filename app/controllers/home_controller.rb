class HomeController < ApplicationController
  def index
  	@order = Order.new
  	@confirmation = Confirmation.new
  end
end
