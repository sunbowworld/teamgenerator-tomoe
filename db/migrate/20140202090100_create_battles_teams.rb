class CreateBattlesTeams < ActiveRecord::Migration
  def change
    create_table :battles_teams do |t|
      t.integer :battle_id
      t.integer :team_id
      t.integer :score
    end
  end
end
