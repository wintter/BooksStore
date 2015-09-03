class DropOrderStates < ActiveRecord::Migration
  def change
    drop_table :order_states, force: :cascade
  end
end
