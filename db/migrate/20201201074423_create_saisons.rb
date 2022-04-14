class CreateSaisons < ActiveRecord::Migration[6.0]
  def change
    create_table :saisons do |t|
      t.string :nomSaison
      t.string :couleur
      

      t.timestamps
    end
  end
end
