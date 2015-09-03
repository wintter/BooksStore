class DropCartTable < ActiveRecord::Migration
  def change
    drop_table :carts, force: :cascade
  end
end
