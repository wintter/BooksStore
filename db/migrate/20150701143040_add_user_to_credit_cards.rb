class AddUserToCreditCards < ActiveRecord::Migration
  def change
    add_reference :credit_cards, :user, index: true, foreign_key: true
  end
end
