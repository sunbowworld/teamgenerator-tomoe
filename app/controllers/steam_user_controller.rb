class SteamUserController < ApplicationController
  def index
    @steam_users = SteamUser.all
  end

  def create
    steam_user = SteamUser.new params[:steam_user]
    unless steam_user.save
      flash[:error] = steam_user.error
    end
  end

  def create_ids
    steam_users = params[:steam_id64s].map do |steam_id64|
      if !steam_id64.empty? && SteamUser.where(steam_id64: steam_id64).blank?
        st = SteamUser.new
        st.steam_id64 = steam_id64
      end
    end
    steam_users.compact.each(&:save)
    redirect_to action: :index
  end

  def steam_group
    @steam_group = SteamGroup.new(params[:group_id])
    @steam_ids = @steam_group.members.map do |member|
      SteamId.new member.steam_id64
    end
  end
end
