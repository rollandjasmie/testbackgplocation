class CreatePaimentpartiels < ActiveRecord::Migration[6.0]
  def change
    create_table :paimentpartiels do |t|
      t.string :description
      t.float :typ
      t.float :montant
      t.float :minimal

      t.timestamps
    end
  end
end
