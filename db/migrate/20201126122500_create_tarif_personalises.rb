class CreateTarifPersonalises < ActiveRecord::Migration[6.0]
  def change
    create_table :tarif_personalises do |t|
      t.date :dateDebutPerso
      t.date :dateFinPerso
      t.integer :prix
      t.belongs_to :category, index:true
      t.belongs_to :jour, index:true

      t.timestamps
    end
  end
end
