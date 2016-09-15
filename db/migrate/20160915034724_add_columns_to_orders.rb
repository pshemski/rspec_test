class AddColumnsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :state_id, :integer
    add_column :orders, :delivery_id, :integer
  end
end
