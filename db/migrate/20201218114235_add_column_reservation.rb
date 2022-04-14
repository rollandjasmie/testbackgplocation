class AddColumnReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :numero_vol, :string
  end
end
