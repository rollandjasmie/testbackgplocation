class CreateOuvertexceptions < ActiveRecord::Migration[6.0]
  def change
    create_table :ouvertexceptions do |t|
      t.date :jourouvertdebut
      t.date :jourouvertfin

      t.timestamps
    end
  end
end
