class TeamController < ApplicationController
  
  # チーム一覧表示
  def index
    
  end
  
  # 新規チーム作成
  def create
    group = Group.find(params[:group])
    teams = params[:teams].map do |user_ids|
      unless team = Team.find_by_steam_user_ids(group, user_ids)
        team = Team.new(group: group, steam_users: user_ids)
        team.save!
      end
      team
    end
    
    redirect_to controller: "battle", action: "new", json: {'teams' => teams.map{|t| t.id}}.to_json
  end
  
  # チーム詳細表示
  def show
    
  end
  
  # チーム生成画面表示
  def generate
    @steam_ids = SteamUser.all.map(&:get_SteamId)
  end
end
