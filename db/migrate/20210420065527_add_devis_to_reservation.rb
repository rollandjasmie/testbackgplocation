class AddDevisToReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :valide, :int
    add_column :reservations, :envoi, :date
    

  end
end
