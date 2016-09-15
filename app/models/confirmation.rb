class Confirmation < ActiveRecord::Base
	belongs_to :order
	belongs_to :customer
	validates :phone_number, presence: true
end
