require 'rails_helper'

RSpec.describe "Customer Order Journey", type: :request do

  let(:order_params) {
    {
      weight_in_kg: 12,
      quantity: 1,
      preferred_time: Time.now,
      notes: "notes",
      payment_amount_in_cents: 2500,
      brand_id: Brand.find_or_create_by(name: "Petron").id,
      customer_id: nil,
      state_id: nil,
      delivery_id: nil
    }
  }

  let(:customer_params) {
    {
      name: "test name",
      email: "test@nextacademy.com",
      delivery_address: "1 jalan 2/3 Kuala Lumpur Malaysia",
      postcode: "12345"
    }
  }

  describe "Order form" do
    it "loads the order form" do
      get root_path

      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it "shows the correct fields in the order form" do
      get root_path

      brand_select_form = '<select name="order[brand_id]" id="order_brand_id">'
      weight_select_form = '<select name="order[weight_in_kg]" id="order_weight_in_kg">'
      quantity_select_form = '<select name="order[quantity]" id="order_quantity">'
      time_input_form = 'name="order[preferred_time]"'
      notes_input_form = 'name="order[notes]"'
      submit_button = '<input type="submit"'

      expect(response.body).to include('action="/orders')
      expect(response.body).to include(brand_select_form)
      expect(response.body).to include(weight_select_form)
      expect(response.body).to include(quantity_select_form)
      expect(response.body).to include(time_input_form)
      expect(response.body).to include(notes_input_form)
      expect(response.body).to include(submit_button)
    end

    it "shows a confirmation form where a customer can enter their confirmation code" do
      get root_path

      expect(response.body).to include('action="/confirmations')
      expect(response.body).to include("Have a confirmation code? Enter it here:")
      expect(response.body).to include('name="confirmation[otp]"')
    end

    it "creates an order and redirects to the customer info page" do
      get root_path
      post "/orders", order: order_params

      expect(response).to redirect_to(new_customer_path)
    end
  end

  describe "Customer form" do
    it "shows the new customer info page after redirection" do
      get root_path
      post "/orders", order: order_params
      follow_redirect!

      expect(response).to render_template(:new)
    end

    it "tells the user that an order has been created and gives extra instructions" do
      get root_path
      post "/orders", order: order_params
      follow_redirect!

      expect(response.body).to include("Order successfully created! Now tell us where to send it.")
    end

    it "redirects to the confirmation page to ask for their phone number" do
      get root_path
      post "/orders", order: order_params
      follow_redirect!
      post "/customers", customer: customer_params

      expect(response).to redirect_to(new_confirmation_path)
    end
  end

  describe "Confirmation form" do
    it "shows the new confirmation page after redirection" do
      get root_path
      post "/orders", order: order_params
      follow_redirect!
      post "/customers", customer: customer_params
      follow_redirect!

      expect(response).to render_template(:new)
    end

    it "asks the user for their phone number" do
      get root_path
      post "/orders", order: order_params
      follow_redirect!
      post "/customers", customer: customer_params
      follow_redirect!

      expect(response.body).to include("One last step: Please enter your phone number so we can send you a confirmation SMS")
    end

    it "redirects to the root path after entering the phone number" do
      get root_path
      post "/orders", order: order_params
      follow_redirect!
      post "/customers", customer: customer_params
      follow_redirect!
      post "/confirmations", confirmation: { phone_number: "5559876" }

      expect(response).to redirect_to(root_path)
    end

    it "redirects to the order summary page after entering the confirmation" do
      get root_path
      post "/orders", order: order_params
      follow_redirect!
      post "/customers", customer: customer_params
      follow_redirect!
      post "/confirmations", confirmation: { phone_number: "5559876" }
      follow_redirect!
      post "/confirmations", confirmation: { otp: Confirmation.first.otp }

      expect(response).to redirect_to(order_summary_path(Order.first))
    end

    it "shows the summary page" do
      get root_path
      post "/orders", order: order_params
      follow_redirect!
      post "/customers", customer: customer_params
      follow_redirect!
      post "/confirmations", confirmation: { phone_number: "5559876" }
      follow_redirect!
      post "/confirmations", confirmation: { otp: Confirmation.first.otp }
      follow_redirect!

      expect(response).to render_template(:summary)
    end
  end
end
