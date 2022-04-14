class CreateBaseTarifs < ActiveRecord::Migration[6.0]
  def change
    create_table :base_tarifs do |t|
      t.integer :jourDebut
      t.integer :jourFin
      t.float :prixBasseSaison
      t.float :prixMoyenneSaison
      t.float :prixHauteSaison
      t.boolean :check


      t.belongs_to :category, index:true
      t.timestamps
    end
  end
end
