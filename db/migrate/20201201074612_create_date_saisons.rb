class CreateDateSaisons < ActiveRecord::Migration[6.0]
  def change
    create_table :date_saisons do |t|
      t.date :dateDSaison
      t.date :dateFsaison
      t.belongs_to :saison, index:true

      t.timestamps
    end
  end
end
