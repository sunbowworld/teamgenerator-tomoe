class Team < ActiveRecord::Base
  has_and_belongs_to_many :steam_users
  has_and_belongs_to_many :versus_informations
  has_many :teams_versus_informations
  belongs_to :group

  validates :name, presence: true
  validates :name, length: { maximum: DB_STRING_MAX }
end
