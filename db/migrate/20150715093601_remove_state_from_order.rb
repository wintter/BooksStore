class RemoveStateFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :state, :string
  end
end
