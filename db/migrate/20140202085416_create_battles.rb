class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.datetime :battle_at, null: false
      t.timestamps
    end
  end
end
