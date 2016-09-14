require "rails_helper"

describe Delivery, type: :model do
  context "model relationships" do
    it { is_expected.to have_many(:orders) }
  end
end