class ChangeAddress < ActiveRecord::Migration
  def change
    remove_column :addresses, :billing_address
    remove_column :addresses, :shipping_address
    add_column :addresses, :street_address, :string
  end
end
