class RemoveUserIdFromCreditCard < ActiveRecord::Migration
  def change
    remove_column :credit_cards, :user_id
  end
end
