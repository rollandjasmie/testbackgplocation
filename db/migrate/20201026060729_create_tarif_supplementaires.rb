class CreateTarifSupplementaires < ActiveRecord::Migration[6.0]
  def change
    create_table :tarif_supplementaires do |t|
      t.string :libelle
      t.integer :prix
      # t.references :tarif, null: false, foreign_key: true

      t.timestamps
    end
  end
end
