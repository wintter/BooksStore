class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|

      t.decimal :total_price, precision: 5, scale: 2
      t.datetime :completed_date
      t.string :state

      t.timestamps null: false
    end
    add_reference :orders, :user, index: true, foreign_key: true
    add_reference :orders, :credit_card, index: true, foreign_key: true
  end
end
