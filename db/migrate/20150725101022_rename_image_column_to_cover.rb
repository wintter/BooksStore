class RenameImageColumnToCover < ActiveRecord::Migration
  def change
    rename_column :books, :image, :cover
  end
end
