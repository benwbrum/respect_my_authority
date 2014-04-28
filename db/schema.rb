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

ActiveRecord::Schema.define(version: 20140428151032) do

  create_table "analyses", force: true do |t|
    t.string   "data_provider"
    t.string   "subject"
    t.string   "q"
    t.string   "status",        default: "pending"
    t.integer  "result_count",  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.integer  "items",        default: 0
    t.boolean  "has_loc_sh"
    t.boolean  "loc_sh_alias"
    t.string   "loc_sh_url"
    t.integer  "analysis_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["analysis_id"], name: "index_subjects_on_analysis_id"

end
