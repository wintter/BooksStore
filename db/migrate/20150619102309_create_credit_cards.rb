class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|

      t.string :number
      t.string :CVV
      t.integer :expiration_month
      t.integer :expiration_year
      t.string :first_name
      t.string :last_name
      t.timestamps null: false
    end
    add_reference :credit_cards, :customer, index: true, foreign_key: true
  end
end
