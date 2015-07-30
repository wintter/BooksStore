class AddBookToWishLists < ActiveRecord::Migration
  def change
    add_reference :wish_lists, :book, index: true, foreign_key: true
  end
end
