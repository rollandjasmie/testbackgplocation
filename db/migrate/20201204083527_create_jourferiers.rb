class CreateJourferiers < ActiveRecord::Migration[6.0]
  def change
    create_table :jourferiers do |t|
      t.string :evenement
      t.date :dateferie
      t.integer :anne
      t.integer :surplus

      t.timestamps
    end
  end
end
