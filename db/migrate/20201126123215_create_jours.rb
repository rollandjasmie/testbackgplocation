class CreateJours < ActiveRecord::Migration[6.0]
  def change
    create_table :jours do |t|
      t.string :name
      t.integer :nombrejour

      t.timestamps
    end
  end
end
