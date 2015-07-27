class AddApproveToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :approve, :boolean, default: false
  end
end
