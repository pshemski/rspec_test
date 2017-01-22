class Customer < ActiveRecord::Base
	has_many :confirmations
	has_many :orders
end
