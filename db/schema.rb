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

ActiveRecord::Schema.define(version: 20150109223518) do

  create_table "episodes", force: :cascade do |t|
    t.integer  "episode_id",  limit: 4
    t.string   "title",       limit: 255
    t.string   "categories",  limit: 255
    t.string   "episode_url", limit: 255
    t.string   "image_urls",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "episodes", ["episode_id"], name: "index_episodes_on_episode_id", unique: true, using: :btree

end
