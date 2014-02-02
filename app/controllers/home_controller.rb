class HomeController < ApplicationController
  def index
    @steam_ids = SteamUser.all.map(&:get_SteamId)
  end

  def add
    steam_users = params[:steam_id64s].map do |steam_id64|
      if !steam_id64.empty? && SteamUser.where(steam_id64: steam_id64).blank?
        st = SteamUser.new
        st.steam_id64 =  steam_id64
        st
      end
    end
    steam_users.compact.each(&:save)
    redirect_to '/home/index'
  end

  def show_group
    @steam_group = SteamGroup.new(params[:group_id])
    @steam_ids = @steam_group.members.map do |member|
      SteamId.new member.steam_id64
    end
  end

  # test method.
  # TODO: delete
  def generator
    render text: params[:json]
  end
end
