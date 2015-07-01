class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.text :review
      t.integer :rating_number

      t.timestamps null: false
    end
    add_reference :ratings, :user, index: true, foreign_key: true
    add_reference :ratings, :book, index: true, foreign_key: true
  end
end
