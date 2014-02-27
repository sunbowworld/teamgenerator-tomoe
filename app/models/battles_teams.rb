class BattlesTeams < ActiveRecord::Base
  belongs_to :battle
  belongs_to :team
end
