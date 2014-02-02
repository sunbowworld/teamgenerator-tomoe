module ApplicationHelper
  def steam_card(steam_id)
    render :inline => <<-HAML, :type => :haml, :locals => {:steam_id => steam_id}
.steam_card.col-md-4.well{id: steam_id.steam_id64}
  .avator
    = image_tag steam_id.icon_url
  .name
    = steam_id.nickname
    HAML
  end

  def steam_card_sidebar(steam_id)
    render :inline => <<-HAML, :type => :haml, :locals => {:steam_id => steam_id}
.steam_card.well{id: steam_id.steam_id64}
  .avator
    = image_tag steam_id.icon_url
  .name
    = steam_id.nickname
    HAML
  end
end
