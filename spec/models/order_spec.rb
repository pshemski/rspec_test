require "rails_helper"

describe Order, type: :model do
  context "model relationships" do
    it { is_expected.to belong_to(:brand) }
    it { is_expected.to belong_to(:customer) }
    it { is_expected.to belong_to(:state) }
    it { is_expected.to belong_to(:delivery) }
    it { is_expected.to have_one(:confirmation) }
  end

  Given(:customer_params) {
    {
      name: "test name",
      email: "test@nextacademy.com",
      delivery_address: "1 jalan 2/3 Kuala Lumpur Malaysia",
      postcode: "12345"
    }
  }
  Given(:customer) { Customer.create(customer_params) }
  Given(:default_order_params) {
    {
      weight_in_kg: 12,
      quantity: 1,
      preferred_time: Time.now,
      notes: "notes",
      payment_amount_in_cents: 2500,
      brand_id: Brand.find_or_create_by(name: "Petron").id,
      customer_id: customer,
    }
  }

  context "it makes sure an order starts as pending" do
    Given(:order) { Order.create(default_order_params) }
    When(:result) { order.state }
    Then { result == State.find_by(state: "pending") }
  end

  describe "#confirm!" do
    context "it sets the order state to 'confirmed'" do
      Given(:order) { Order.create(default_order_params) }
      When { order.confirm! }
      Then { order.state == State.find_by(state: "confirmed") }
    end

    context "it only changes the state if the order state is pending" do
      Given(:order) { Order.create(default_order_params) }
      context "order state is confirmed" do
        Given { order.state = State.find_by(state: "confirmed") }
        Then { order.state == State.find_by(state: "confirmed") }
      end

      context "order state is assigned" do
        Given { order.state = State.find_by(state: "assigned") }
        Then { order.state == State.find_by(state: "assigned") }
      end

      context "order state is in_transit" do
        Given { order.state = State.find_by(state: "in_transit") }
        Then { order.state == State.find_by(state: "in_transit") }
      end

      context "order state is delivered" do
        Given { order.state = State.find_by(state: "delivered") }
        Then { order.state == State.find_by(state: "delivered") }
      end
    end
  end

  context "scopes" do
    context "it returns all orders that are not pending" do
      Given(:pending) {
        Order.create!(default_order_params.merge(state: State.find_by(state: "pending")))
      }
      Given {
        Order.create!(default_order_params.merge(state: State.find_by(state: "confirmed")))
        Order.create!(default_order_params.merge(state: State.find_by(state: "assigned")))
        Order.create!(default_order_params.merge(state: State.find_by(state: "in_transit")))
      }
      When(:results) { Order.not_pending }
      Then { expect(results).to_not include(pending) }
      Then { results.count == 3 }
    end

    context "it returns all orders that are not yet delivered" do
      Given(:delivered) {
        Order.create!(default_order_params.merge(state: State.find_by(state: "delivered")))
      }
      Given {
        Order.create!(default_order_params.merge(state: State.find_by(state: "confirmed")))
        Order.create!(default_order_params.merge(state: State.find_by(state: "assigned")))
      }
      When(:results) { Order.not_delivered }
      Then { expect(results).to_not include(delivered) }
      Then { results.count == 2 }
    end

    context "it returns all orders that have been assigned to a delivery person" do
      Given(:delivery_parmas) {
        {
          name: "delivery person",
          phone_number: "000"
        }
      }
      Given(:delivery) { Delivery.create(delivery_parmas) }
      Given(:unassigned) {
        Order.create!(default_order_params.merge(delivery: nil))
      }
      Given {
        4.times { Order.create!(default_order_params.merge(delivery: delivery)) }
      }
      When(:results) { Order.assigned_to(delivery.id) }
      Then { expect(results).to_not include(unassigned) }
      Then { results.count == 4 }
    end
    context "it returns all orders that are actionable" do
      # actionable means:
      # * is not pending (confirmed, assigned, or in_transit)
      # * is not yet delivered
      # * is not assigned to other delivery person
      Given(:delivery_parmas) {
        {
          name: "delivery person",
          phone_number: "000"
        }
      }
      Given(:delivery) { Delivery.create(delivery_parmas) }
      Given(:unassigned) {
        Order.create!(default_order_params.merge(
          state: State.find_by(state: "assigned"),
          delivery: nil
        ))
      }
      Given(:pending) {
        Order.create!(default_order_params.merge(
          state: State.find_by(state: "pending")
        ))
      }
      Given(:delivered) {
        Order.create!(default_order_params.merge(
          state: State.find_by(state: "delivered"),
          delivery: delivery
        ))
      }
      Given {
        Order.create!(default_order_params.merge(
          state: State.find_by(state: "confirmed")
        ))
        Order.create!(default_order_params.merge(
          state: State.find_by(state: "assigned"),
          delivery: delivery
        ))
        Order.create!(default_order_params.merge(
          state: State.find_by(state: "in_transit"),
          delivery: delivery
        ))
      }
      When(:results) { Order.actionable_orders_by_delivery_person(delivery.id) }
      Then { expect(results).to_not include(unassigned) }
      Then { expect(results).to_not include(pending) }
      Then { expect(results).to_not include(delivered) }
      Then { results.count == 3 }
    end
  end
end