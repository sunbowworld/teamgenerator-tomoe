class SteamUser < ActiveRecord::Base

  after_initialize :steam_user_init
  extend Forwardable

  def_delegators :@steam_id, :icon_url, :nickname

  has_and_belongs_to_many :teams
  has_and_belongs_to_many :groups

  validate :steam_id64_check

  def steam_user_init ( attributes = {}, options = {} )
    self.steam_id64 ||= attributes[:steam_id64]
    begin
      @steam_id = SteamId.new self.steam_id64 if self.steam_id64
    rescue
    end
  end

  def steam_id64_check
    begin
      SteamId.new steam_id64
    rescue
      errors.add(:api, $!.to_s)
    end
  end

end
