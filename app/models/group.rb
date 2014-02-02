class Group < ActiveRecord::Base
  has_many :teams
  has_and_belongs_to_many :steam_users

  validates :name, presence: true
  validates :name, length: { maximum: DB_STRING_MAX }
end
