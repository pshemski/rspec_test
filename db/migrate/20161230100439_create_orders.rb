class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :notes
      t.integer :payment_amount_in_cents
      t.datetime :preffered_time
      t.integer :quantity
      t.integer :weight_in_kg
      t.integer :brand_id
      t.integer :delivery_id
      t.integer :state_id
      t.integer :customer_id
      t.integer :confirmation_id

      t.timestamps null: false
    end
  end
end
