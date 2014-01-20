class CreateVersusInformations < ActiveRecord::Migration
  def change
    create_table :versus_informations do |t|
      t.datetime :versus_at
      t.timestamps
    end
  end
end
