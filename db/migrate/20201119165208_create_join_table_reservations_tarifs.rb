class CreateJoinTableReservationsTarifs < ActiveRecord::Migration[6.0]
  def change
    create_join_table :reservations, :tarifs do |t|
      t.index [:reservation_id, :tarif_id]
      t.index [:tarif_id, :reservation_id]
    end
  end
end
