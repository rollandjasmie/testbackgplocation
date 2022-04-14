class AddPasswordResetColumnsToClient < ActiveRecord::Migration[6.0]
  def change
  	add_column :clients, :reset_password_token, :string
    add_column :clients, :reset_password_sent_at, :datetime
  end
end
