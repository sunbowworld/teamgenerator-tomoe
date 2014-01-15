module ApplicationHelper
  def steam_card(steam_id)
    render :inline => <<-HAML, :type => :haml, :locals => {:steam_id => steam_id}
.steam_id
  .avator
    = image_tag steam_id.icon_url
  .name
    = steam_id.nickname
    HAML
  end
end
