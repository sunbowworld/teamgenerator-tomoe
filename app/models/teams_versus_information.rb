class TeamsVersusInformation < ActiveRecord::Base
  belongs_to :versus_information
  belongs_to :team
end
