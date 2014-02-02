class Battle < ActiveRecord::Base
  has_and_belongs_to_many :teams
  has_many :battles_teams, class_name: 'BattlesTeams'
end
