class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :brand
  belongs_to :state
  belongs_to :delivery
  has_one :confirmation

  def confirm!
  	confirmed = State.find_by(state: 'confirmed')
  	self.update_attribute(:state_id, confirmed.id)
  end
end
