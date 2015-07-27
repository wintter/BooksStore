class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.text :review
      t.integer :rating_number

      t.timestamps null: false
    end
  end
end
