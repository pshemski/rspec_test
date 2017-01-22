class Confirmation < ActiveRecord::Base
	require 'securerandom'
	belongs_to :customer
	belongs_to :order

	validates :phone_number, presence: true

	def self.one_time_password
		SecureRandom.hex(4)
	end
end
