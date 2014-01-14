class VersusInformation < ActiveRecord::Base
  has_and_belongs_to_many :teams
  has_many :teams_versus_informations
end
