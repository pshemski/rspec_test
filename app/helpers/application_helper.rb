module ApplicationHelper

	private

  def log_in(delivery)
  	session[:delivery_id] = delivery.id
  end

  def current_delivery
  	@current_delivery ||= Delivery.find_by(id: session[:delivery_id])
  end

  def logged_in?
    !current_delivery.nil?
  end

  def log_out
    session.delete(:delivery_id)
    @current_delivery = nil
  end

  def new_order(order)
  	session[:order_id] = order.id
  end

  def current_order
  	@current_order ||= Order.find_by(id: session[:order_id])
  end
end