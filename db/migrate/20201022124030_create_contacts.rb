class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :nom
      t.string :prenom
      t.string :email
      t.string :telephone
      t.text :message
      
      t.timestamps
    end
  end
end
