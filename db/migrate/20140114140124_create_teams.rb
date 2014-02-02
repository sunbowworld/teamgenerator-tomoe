class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :group_id
      t.string :name
      t.string :steam_users_index, null: false
      t.timestamps
    end
  end
end
