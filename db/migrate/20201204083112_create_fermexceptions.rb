class CreateFermexceptions < ActiveRecord::Migration[6.0]
  def change
    create_table :fermexceptions do |t|
      t.date :jourfermedebut
      t.date :jourfermefin

      t.timestamps
    end
  end
end
