class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.belongs_to :cart, index: true, foreign_key: true
      t.belongs_to :book, index: true, foreign_key: true
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
