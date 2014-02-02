class AddIdsToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :ids, :string, :null => false
  end
end
