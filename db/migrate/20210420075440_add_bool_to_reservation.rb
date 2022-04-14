class AddBoolToReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :si_envoier, :boolean
  end
end
