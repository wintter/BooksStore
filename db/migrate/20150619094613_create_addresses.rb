class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.text :billing_address
      t.string :shipping_address
      t.string :city
      t.string :phone

      t.timestamps null: false
    end
  end
end
