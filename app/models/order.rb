class Order < ActiveRecord::Base
	has_one :confirmation
	belongs_to :brand
	belongs_to :delivery
	belongs_to :state
	belongs_to :customer

	def self.update_state(order)	
		case order.state
			when order.state == State.pending
				order.state = State.confirmed
			when order.state == State.confirmed
				order.state = State.assigned
			when order.state == State.assigned
				order.state = State.in_transit
			else
				order.state = State.delivered
		end
	end
end
