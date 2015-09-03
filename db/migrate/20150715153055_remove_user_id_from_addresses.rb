class RemoveUserIdFromAddresses < ActiveRecord::Migration
  def change
    remove_column :addresses, :user_id
    add_column :addresses, :zip, :string
  end
end
