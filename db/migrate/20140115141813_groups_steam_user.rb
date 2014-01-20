class GroupsSteamUser < ActiveRecord::Migration
  def change
    create_table :groups_steam_users do |t|
      t.integer :group_id
      t.integer :steam_user_id
    end
  end
end
