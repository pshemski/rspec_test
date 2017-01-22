class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.boolean :confirmed
      t.string :otp
      t.string :phone_number
      t.integer :customer_id
      t.integer :order_id

      t.timestamps null: false
    end
  end
end
