class AddBillingAddressToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :billing_address_id, :integer
    add_index :orders, :billing_address_id
  end
end
