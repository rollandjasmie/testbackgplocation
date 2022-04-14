class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :nom
      t.string :prenom
      t.string :telephone
      t.string :email
      t.string :password_digest

      t.timestamps
    end
    add_index :clients, :nom
    add_index :clients, :prenom
    add_index :clients, :telephone, unique: true
    add_index :clients, :email, unique: true
    add_index :clients, :password_digest, unique: true 
  end
end
