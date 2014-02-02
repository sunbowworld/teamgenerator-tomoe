class Team < ActiveRecord::Base
  has_and_belongs_to_many :steam_users
  has_and_belongs_to_many :battles
  has_many :battles_teams, class_name: 'BattleTeams'
  belongs_to :group
  before_save :make_steam_users_index
  
  scope :find_by_steam_user_ids, ->(group, *ids) do
    users_index = ids.flatten.sort.join("-")
    #where(group: group, steam_user_ids: ids_str)
    where(steam_users_index: users_index)
  end
  
  def make_steam_users_index
    steam_users_index = self.steam_users.map {|su| su.id}.sort.join("-")
    self.steam_users_index = steam_users_index
  end
end
