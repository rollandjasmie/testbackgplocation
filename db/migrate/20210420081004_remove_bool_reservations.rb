class RemoveBoolReservations < ActiveRecord::Migration[6.0]
  def change
    remove_column :reservations, :si_envoier, :boolean
  end
end
