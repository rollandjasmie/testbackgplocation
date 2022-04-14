class AddColumnCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :stock, :integer
    add_column :categories, :duree_min_bs, :integer
    add_column :categories, :duree_min_ms, :integer
    add_column :categories, :duree_min_hs, :integer
  end
end
