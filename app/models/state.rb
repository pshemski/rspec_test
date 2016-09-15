class State < ActiveRecord::Base
	
	def self.pending
		State.find_by(state: 'pending')
	end

	def self.confirmed
		State.find_by(state: 'confirmed')
	end

	def self.assigned
		State.find_by(state: 'assigned')
	end

	def self.in_transit
		State.find_by(state: 'in_transit')
	end

	def self.delivered
		State.find_by(state: 'delivered')
	end
end
