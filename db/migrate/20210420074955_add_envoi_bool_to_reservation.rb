class AddEnvoiBoolToReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :si_envoi, :boolean
  end
end
