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

ActiveRecord::Schema.define(version: 20160228031126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: :cascade do |t|
    t.integer  "option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "poll_options", force: :cascade do |t|
    t.integer  "poll_id"
    t.integer  "option_id"
    t.boolean  "winning_poll", default: false
    t.integer  "votes",        default: 0
    t.string   "user_ids"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "polls", force: :cascade do |t|
    t.string   "title"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_polls", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "poll_id"
    t.boolean  "admin",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_polls", ["user_id", "poll_id"], name: "index_user_polls_on_user_id_and_poll_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.integer  "fb_id"
    t.string   "profilePicture"
    t.string   "first_name",     limit: 50,              null: false
    t.string   "last_name",      limit: 50,              null: false
    t.string   "email",          limit: 50, default: "", null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

end
