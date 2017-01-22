require "rails_helper"

describe OrdersController, type: :controller do
  let(:order_params) {
    {
      weight_in_kg: 12,
      quantity: 1,
      preffered_time: Time.now,
      notes: "notes",
      payment_amount_in_cents: 2500,
      brand_id: Brand.find_or_create_by(name: "Petron").id,
      customer_id: nil,
      state_id: nil,
      delivery_id: nil
    }
  }

  describe "create" do
    it "stores the order_id in the session" do
      post :create, order: order_params
      expect(session.keys).to include("order_id")
      expect(session["order_id"]).to eq Order.first.id
    end
  end
end