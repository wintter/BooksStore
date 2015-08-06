class DropAddressFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :address_id
  end
end
