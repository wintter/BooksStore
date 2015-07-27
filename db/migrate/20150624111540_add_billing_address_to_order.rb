class AddBillingAddressToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :billing_address, :string
    add_index :orders, :billing_address
  end
end
