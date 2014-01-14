class SteamUser < ActiveRecord::Base
  has_and_belongs_to_many :teams
  def get_SteamId
    SteamId.new steam_id64.to_i
  end
end
