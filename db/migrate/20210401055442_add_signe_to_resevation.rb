class AddSigneToResevation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :signe, :int
  end
end
