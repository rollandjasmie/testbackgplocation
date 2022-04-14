class CreateTarifs < ActiveRecord::Migration[6.0]
  def change
    create_table :tarifs do |t|
      t.date :date_debut
      t.date :date_fin 
      t.string :prix1
      t.string :prix2
      t.string :prix3
      t.string :prix4
      t.string :prix5
      t.string :prix6
     
      t.belongs_to :category, index: true
      
      t.timestamps
    end
    
  end
end
