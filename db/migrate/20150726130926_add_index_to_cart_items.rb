class AddIndexToCartItems < ActiveRecord::Migration
  def change
    add_index :order_items, [:cart_id, :book_id], unique: true
  end
end
