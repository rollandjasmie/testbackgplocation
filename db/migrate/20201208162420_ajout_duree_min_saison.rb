class AjoutDureeMinSaison < ActiveRecord::Migration[6.0]
  def change
    add_column :saisons, :duree_min, :integer
  end
end
