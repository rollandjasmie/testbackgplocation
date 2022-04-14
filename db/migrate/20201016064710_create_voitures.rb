class CreateVoitures < ActiveRecord::Migration[6.0]
  def change
    create_table :voitures do |t|
      t.string :image
      t.string :marque
      t.string :model
      t.string :places
      t.string :mode
      t.string :climatisation
      t.string :vitesse
      t.string :portes
      # t.string :status
      t.belongs_to :category, index: true

      t.timestamps
    end
  end
end
