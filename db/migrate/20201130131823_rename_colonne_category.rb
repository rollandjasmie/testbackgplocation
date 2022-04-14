class RenameColonneCategory < ActiveRecord::Migration[6.0]
  def change
    rename_column :categories, :category, :name
  end
end
