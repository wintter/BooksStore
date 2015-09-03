class CreateWishLists < ActiveRecord::Migration
  def change
    create_table :wish_lists do |t|

      t.timestamps null: false
    end
  end
end
