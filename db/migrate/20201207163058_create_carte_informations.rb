class CreateCarteInformations < ActiveRecord::Migration[6.0]
  def change
    create_table :carte_informations do |t|
      t.string :numero_carte
      t.integer :cvv
      t.string :date_expiration_carte
      t.belongs_to :client, index:true

      t.timestamps
    end
  end
end
