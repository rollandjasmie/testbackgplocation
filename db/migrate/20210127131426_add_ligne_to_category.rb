class AddLigneToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :enligne, :boolean
  end
end
