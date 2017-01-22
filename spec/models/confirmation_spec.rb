require 'rails_helper'

describe Confirmation, type: :model do
  context "model relationships" do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:customer) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:phone_number) }
  end

  Given(:customer_params) {
    {
      name: "test",
      delivery_address: "1 Jalan 2/3 Petaling Jaya Malaysia",
      email: "test@nextacademy.com",
      postcode: "12345"
    }
  }
  Given(:order_params) {
    {
      weight_in_kg: 12,
      quantity: 1,
      preffered_time: Time.now,
      notes: "none",
      brand_id: Brand.first.id,
      customer_id: customer.id
    }
  }
  Given(:customer) { Customer.create(customer_params) }
  Given(:order) { Order.create(order_params) }
  Given(:confirmation_params) {
    { customer: customer, order: order, phone_number: "5558888" }
  }
  context "it generates a one time password" do
    When(:confirmation) { Confirmation.create(confirmation_params) }

    Then { confirmation.otp != nil }
    Then { confirmation.confirmed? == false }
  end

  context "it does not overwrite the otp when saved again" do
    Given(:confirmation) { Confirmation.create(confirmation_params) }
    Given(:otp) { confirmation.otp }
    When { confirmation.confirmed = true; confirmation.save }
    Then { confirmation.otp == otp }
  end
end