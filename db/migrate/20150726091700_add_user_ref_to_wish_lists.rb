class AddUserRefToWishLists < ActiveRecord::Migration
  def change
    add_reference :wish_lists, :user, index: true, foreign_key: true
  end
end
