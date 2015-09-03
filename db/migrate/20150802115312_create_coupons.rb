class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|

      t.string :number
      t.string :discount, precision: 5, scale: 2
      t.timestamps null: false
    end
  end
end
