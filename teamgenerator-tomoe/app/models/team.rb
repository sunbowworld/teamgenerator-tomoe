class Team < ActiveRecord::Base
  has_and_belongs_to_many :steam_users
  has_and_belongs_to_many :versus_informations
  has_many :teams_versus_informations
  belongs_to :group
end
