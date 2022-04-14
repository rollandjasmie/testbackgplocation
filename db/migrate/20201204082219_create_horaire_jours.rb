class CreateHoraireJours < ActiveRecord::Migration[6.0]
  def change
    create_table :horaire_jours do |t|
      t.string :nomjour
      t.string :heuredebut
      t.string :heurefin
      t.integer :prixsurplus

      t.timestamps
    end
  end
end
