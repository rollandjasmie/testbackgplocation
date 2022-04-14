class EnvoiChangeColumnDatetime < ActiveRecord::Migration[6.0]
  def change
    change_column(:reservations, :envoi, :datetime)
  end
end
