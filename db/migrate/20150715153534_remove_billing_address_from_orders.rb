class RemoveBillingAddressFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :billing_address
    remove_column :orders, :shipping_address
  end
end
