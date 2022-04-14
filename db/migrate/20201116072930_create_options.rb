class CreateOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :options do |t|
      t.string :libelle
      t.integer :prix
      t.belongs_to :category, index:true

      t.timestamps
    end
  end
end
