class AddOrderStateToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :order_state, index: true, foreign_key: true
  end
end
