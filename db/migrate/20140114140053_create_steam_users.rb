class CreateSteamUsers < ActiveRecord::Migration
  def change
    create_table :steam_users do |t|
      t.integer :steam_id64, :limit => 8
      t.string :name
      t.timestamps
    end
    add_index :steam_users, :steam_id64, unique: true
  end
end
