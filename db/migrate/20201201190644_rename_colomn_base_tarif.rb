class RenameColomnBaseTarif < ActiveRecord::Migration[6.0]
  def change 
    change_table :base_tarifs do |t|
      t.rename :jourDebut, :jourdebut
      t.rename :jourFin, :jourfin
      t.rename :prixBasseSaison, :prixbassesaison
      t.rename :prixMoyenneSaison, :prixmoyennesaison
      t.rename :prixHauteSaison, :prixhautesaison
    end
  end
end
