class AddNameToTarifPersonalises < ActiveRecord::Migration[6.0]
  def change
    add_column :tarif_personalises, :jourDebut, :integer
    add_column :tarif_personalises, :jourFin, :integer
  end
end
