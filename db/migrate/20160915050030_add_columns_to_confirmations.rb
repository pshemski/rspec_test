class AddColumnsToConfirmations < ActiveRecord::Migration
  def change
    add_column :confirmations, :confirmed, :boolean
    add_column :confirmations, :otp, :string
  end
end
