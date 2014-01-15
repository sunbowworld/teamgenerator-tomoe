# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140115141813) do

  create_table "groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_steam_users", force: true do |t|
    t.integer "group_id"
    t.integer "steam_user_id"
  end

  create_table "groups_teams", force: true do |t|
    t.integer "group_id"
    t.integer "team_id"
  end

  create_table "steam_users", force: true do |t|
    t.integer  "steam_id64", limit: 8
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "steam_users", ["steam_id64"], name: "index_steam_users_on_steam_id64", unique: true

  create_table "steam_users_teams", force: true do |t|
    t.integer "steam_user_id"
    t.integer "team_id"
  end

  create_table "teams", force: true do |t|
    t.string   "team_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams_versus_informations", force: true do |t|
    t.integer  "team_id"
    t.integer  "versus_information_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versus_informations", force: true do |t|
    t.datetime "versus_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
