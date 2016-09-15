class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :weight_in_kg
      t.integer :quantity
      t.datetime :preferred_time
      t.string :notes
      t.integer :brand_id
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
