require 'rails_helper'

RSpec.describe "Deliveries", type: :request do

  let(:delivery_params) {
    {
      name: "delivery person",
      phone_number: "8881234"
    }
  }
  let!(:delivery) { Delivery.create(delivery_params) }

  describe "Login" do
    it "redirects to the login page" do
      get deliveries_path

      expect(response).to redirect_to(login_deliveries_path)
    end

    it "shows the login form" do
      get deliveries_path
      follow_redirect!

      expect(response).to render_template(:login)
    end

    it "redirects to the order list after logging in" do
      get deliveries_path
      follow_redirect!
      post deliveries_path, delivery: delivery_params

      expect(response).to redirect_to delivery_orders_path(delivery)
    end
  end

  describe "order dashboard" do
    let(:customer_params) {
      {
        name: "test name",
        email: "test@nextacademy.com",
        delivery_address: "1 jalan 2/3 Kuala Lumpur Malaysia",
        postcode: "12345"
      }
    }
    let(:customer) { Customer.create(customer_params) }

    let(:order_params) {
      {
        weight_in_kg: 12,
        quantity: 1,
        preffered_time: Time.now,
        notes: "notes",
        payment_amount_in_cents: 2500,
        brand: Brand.find_or_create_by(name: "Petron"),
        state_id: nil,
      }
    }

    let(:order) {
      Order.create(order_params.merge(customer: customer, delivery: delivery))
    }
    before do
      order.confirm!
    end

    it "shows a list of orders by customers" do
      get deliveries_path
      follow_redirect!
      post deliveries_path, delivery: delivery_params
      follow_redirect!

      assert_select "button", "Assign to me"
    end

    it "shows 'In Transit' if user clicks on the button 'assign to me'" do
      get deliveries_path
      follow_redirect!
      post deliveries_path, delivery: delivery_params
      follow_redirect!
      put order_path(order), order: {state_id: State.assigned.id}
      follow_redirect!

      assert_select "button", "In Transit"
    end

    it "shows 'Delivered' if user clicks on the button 'in_transit'" do
      get deliveries_path
      follow_redirect!
      post deliveries_path, delivery: delivery_params
      follow_redirect!
      put order_path(order), order: {state_id: State.in_transit.id}
      follow_redirect!

      assert_select "button", "Delivered"
    end

    it "does not show anything if user clicks on the button 'delivered'" do
      get deliveries_path
      follow_redirect!
      post deliveries_path, delivery: delivery_params
      follow_redirect!
      put order_path(order), order: {state_id: State.delivered.id}
      follow_redirect!

      assert_select "button", false, "This page must not contain any buttons"
    end

    it "sends the customer an email whenever the state gets changed" do
      ActionMailer::Base.deliveries.clear

      get deliveries_path
      follow_redirect!
      post deliveries_path, delivery: delivery_params
      follow_redirect!
      put order_path(order), order: {state_id: State.assigned.id}
      follow_redirect!

      expect(ActionMailer::Base.deliveries.count).to eq 1

      put order_path(order), order: {state_id: State.in_transit.id}
      follow_redirect!

      expect(ActionMailer::Base.deliveries.count).to eq 2

      put order_path(order), order: {state_id: State.delivered.id}
      follow_redirect!

      expect(ActionMailer::Base.deliveries.count).to eq 3
    end
  end
end
