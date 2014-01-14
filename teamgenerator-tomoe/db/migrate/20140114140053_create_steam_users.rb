class CreateSteamUsers < ActiveRecord::Migration
  def change
    create_table :steam_users do |t|
      t.string :steam_id64
      t.timestamps
    end
    add_index :steam_users, :steam_id64, unique: true
  end
end
