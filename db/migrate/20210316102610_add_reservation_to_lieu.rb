class AddReservationToLieu < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :lieu_depart, :string
    add_column :reservations, :lieu_retour, :string

  end
end
