class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.text :delivery_address
      t.string :email
      t.string :name
      t.string :postcode

      t.timestamps null: false
    end
  end
end
