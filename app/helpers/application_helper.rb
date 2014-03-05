module ApplicationHelper
  def steam_card(steam_user)
    render :inline => <<-HAML, :type => :haml, :locals => {:steam_user => steam_user}
.steam_card.col-md-4.well{id: steam_user.steam_id64}
  .avator
    = image_tag steam_user.icon_url
  .name
    = steam_user.nickname
    HAML
  end

  def steam_card_sidebar(steam_user)
    render :inline => <<-HAML, :type => :haml, :locals => {:steam_user => steam_user}
.steam_card.well{id: steam_user.steam_id64}
  .avator
    = image_tag steam_user.icon_url
  .name
    = steam_user.nickname
    HAML
  end
end
