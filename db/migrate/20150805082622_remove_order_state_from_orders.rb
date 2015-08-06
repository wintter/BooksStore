class RemoveOrderStateFromOrders < ActiveRecord::Migration
  def change
    remove_reference(:orders, :order_state, index: true)
  end
end
