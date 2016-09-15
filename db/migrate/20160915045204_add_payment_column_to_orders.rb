class AddPaymentColumnToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :payment_amount_in_cents, :integer
  end
end
