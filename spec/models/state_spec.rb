require "rails_helper"

describe State, type: :model do
  context "convenience scopes" do
    it "returns the pending state" do
      expect(State.pending).to eq(State.find_by(state: "pending"))
    end

    it "returns the confirmed state" do
      expect(State.confirmed).to eq(State.find_by(state: "confirmed"))
    end

    it "returns the assigned state" do
      expect(State.assigned).to eq(State.find_by(state: "assigned"))
    end

    it "returns the in_transit state" do
      expect(State.in_transit).to eq(State.find_by(state: "in_transit"))
    end

    it "returns the delivered state" do
      expect(State.delivered).to eq(State.find_by(state: "delivered"))
    end
  end
end