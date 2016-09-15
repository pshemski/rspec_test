class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
    	t.integer :order_id
    	t.integer :customer_id
    	t.integer :phone_number
      t.timestamps null: false
    end
  end
end
