class AddAuthKeyToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :auth_key, :string
    add_index :users, :auth_key, unique: true
  end
end
