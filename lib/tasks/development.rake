namespace :development do
  
  namespace :db do

    desc "開発用初期データ投入"
    task :seed do
      Rake::Task["development:db:create_steam_users"].execute
      Rake::Task["development:db:create_teams"].execute
    end
    
    desc "SteamUser投入(steam_users: 投入ユーザ数)"
    task :create_steam_users do
      steam_users = ENV['steam_users'].to_i
      steam_users.times do |i|
        SteamUser.create(steam_id64: i, name: "SteamUser #{i}")
        puts "Created SteamUser: SteamUser #{i}"
      end
      puts "This task created #{SteamUser.count} steam users."
    end
    
    desc "Team投入(teams: チーム数, members: 1チームのユーザ数)"
    task :create_teams do
      teams = ENV['teams'].to_i
      members = ENV['members'].to_i
      possible_teams = (1..SteamUser.count).to_a.combination(members).to_a
      if teams > possible_teams.size
        abort("作成可能なチーム数は#{possible_teams.size}チームです。")
      end

      possible_teams.each do |pt|
        next unless Team.find_by_steam_user_ids(pt).empty?
        Team.create(steam_users: SteamUser.find(pt))
        puts "Created Team: #{pt.map{|u| "SteamUser #{u}"}.join(",")}"
        break if Team.count == teams
      end
      puts "This task created #{Team.count} teams."
    end
  end
end