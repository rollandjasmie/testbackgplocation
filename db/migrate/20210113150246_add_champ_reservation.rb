class AddChampReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :acompte, :float
  end
end
