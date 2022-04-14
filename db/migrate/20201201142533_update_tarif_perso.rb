class UpdateTarifPerso < ActiveRecord::Migration[6.0]
  def change
    rename_column :tarif_personalises, :dateDebutPerso, :datedebutperso
    rename_column :tarif_personalises, :dateFinPerso, :datefinperso
    rename_column :tarif_personalises, :jourDebut, :jourdebut
    rename_column :tarif_personalises, :jourFin, :jourfin
    rename_column :saisons, :nomSaison, :nomsaison
    rename_column :date_saisons, :dateDSaison, :debutsaison
    rename_column :date_saisons, :dateFsaison, :finsaison
  end
end
