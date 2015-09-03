class AddIndexToWishLists < ActiveRecord::Migration
  def change
    add_index :wish_lists, [:user_id, :book_id], unique: true
  end
end
