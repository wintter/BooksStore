class AddCountPagesToBooks < ActiveRecord::Migration
  def change
    add_column :books, :count_pages, :integer
  end
end
