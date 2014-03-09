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
    steam_users = params[:staem_id64s].each do |steam_id64|
      SteamUser.create steam_id64: steam_id64 if SteamUser.where(steam_id64: steam_id64).blank?
    end
    redirect_to action: :index
  end

  def search_group
    @steam_group = SteamGroup.new(params[:group_id])
    @steam_users = @steam_group.members.map do |member|
      SteamId.new member.steam_id64
    end
  end
end
