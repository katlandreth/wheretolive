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

ActiveRecord::Schema.define(version: 20171018063655) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.integer "population"
    t.string  "name"
    t.string  "country_code"
    t.float   "reading_score"
    t.float   "science_score"
    t.float   "math_score"
    t.float   "life_satisfaction_score"
    t.float   "freedom_of_press_score"
    t.float   "cost_of_living_score"
    t.float   "population_density"
    t.float   "education_score"
  end

  create_table "country_aliases", force: :cascade do |t|
    t.string   "name"
    t.integer  "country_display_name_id"
    t.integer  "country_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "display_name"
  end

  add_index "country_aliases", ["country_display_name_id"], name: "index_country_aliases_on_country_display_name_id", using: :btree
  add_index "country_aliases", ["country_id"], name: "index_country_aliases_on_country_id", using: :btree

  create_table "country_codes", force: :cascade do |t|
    t.string   "country_name"
    t.string   "value"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "country_population_densities", force: :cascade do |t|
    t.string "country_name"
    t.float  "value"
  end

  create_table "country_populations", force: :cascade do |t|
    t.string   "country_name"
    t.float    "value"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "raw_cost_of_living_scores", force: :cascade do |t|
    t.string "country_name"
    t.float  "score"
  end

  create_table "raw_freedom_of_press_scores", force: :cascade do |t|
    t.string "country_name"
    t.float  "score"
  end

  create_table "raw_life_satisfaction_scores", force: :cascade do |t|
    t.string "country_name"
    t.float  "score"
  end

  create_table "raw_math_scores", force: :cascade do |t|
    t.string "country_name"
    t.float  "score"
  end

  create_table "raw_reading_scores", force: :cascade do |t|
    t.string "country_name"
    t.float  "score"
  end

  create_table "raw_science_scores", force: :cascade do |t|
    t.string "country_name"
    t.float  "score"
  end

end
