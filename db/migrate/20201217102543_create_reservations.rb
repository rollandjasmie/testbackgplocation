class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.date :date_depart
      t.date :date_retour
      t.string :heure_depart
      t.string :heure_retour
      t.float :prix
      t.belongs_to :client, index:true
      t.belongs_to :voiture, index:true

      t.timestamps
    end
  end
end
