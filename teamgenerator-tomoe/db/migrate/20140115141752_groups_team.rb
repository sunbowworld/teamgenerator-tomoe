class GroupsTeam < ActiveRecord::Migration
  def change
    create_table :groups_teams do |t|
      t.integer :group_id
      t.integer :team_id
    end
  end
end
