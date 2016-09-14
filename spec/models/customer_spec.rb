require "rails_helper"

describe Customer, type: :model do
  context "model relationships" do
    it { is_expected.to have_many(:orders) }
    it { is_expected.to have_many(:confirmations) }
  end
end