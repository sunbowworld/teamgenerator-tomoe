class Group < ActiveRecord::Base
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :steam_users
end