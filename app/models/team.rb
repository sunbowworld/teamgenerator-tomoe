class Team < ActiveRecord::Base
  has_and_belongs_to_many :steam_users
  has_and_belongs_to_many :battles
  has_many :battles_teams, clsss_name: 'BattleTeams'
  belongs_to :group
  
  scope :find_by_user_ids, ->(group, *ids) do
    ids_str = ids.flatten.sort.join("-")
    where(group: group, ids: ids_str)
  end
  

end
