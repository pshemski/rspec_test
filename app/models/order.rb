class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :brand
  belongs_to :state
  belongs_to :delivery
  has_one :confirmation
end
