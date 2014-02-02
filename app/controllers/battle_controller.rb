class BattleController < ApplicationController
  require 'json'
  
  # 対戦結果一覧表示
  def index
    
  end
  
  # 新規対戦結果入力画面表示
  def new
    @teams = Team.find(JSON.parse(params[:json])['teams'])
  end
  
  # 新規対戦結果作成
  def create
    
  end
  
  # 対戦結果編集画面表示
  def edit
    
  end
  
  # 対戦結果編集
  def update
    
  end
  
  # 対戦結果詳細表示
  def show
    
  end
  
end
