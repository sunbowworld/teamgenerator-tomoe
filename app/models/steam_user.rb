class SteamUser < ActiveRecord::Base
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :groups

  validate :steam_id64_check

  def get_SteamId
    SteamId.new steam_id64.to_i
  end

  def steam_id64_check
    begin
      SteamId.new steam_id64
    rescue
      errors.add(:api, $!.to_s)
    end
  end
  
end
