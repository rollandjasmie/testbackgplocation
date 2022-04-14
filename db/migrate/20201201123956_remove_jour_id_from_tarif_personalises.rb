class RemoveJourIdFromTarifPersonalises < ActiveRecord::Migration[6.0]
  def change
    remove_index :tarif_personalises, :jour_id
    remove_column :tarif_personalises, :jour_id, :integer
  end
end
