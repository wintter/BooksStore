class AddShippingAddressToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_address, :string
    add_index :orders, :shipping_address
  end
end
