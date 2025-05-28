# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_05_28_153614) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "matches", force: :cascade do |t|
    t.bigint "white_player_id"
    t.bigint "black_player_id"
    t.string "result", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["black_player_id"], name: "index_matches_on_black_player_id"
    t.index ["white_player_id"], name: "index_matches_on_white_player_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.date "birthday"
    t.integer "games_played"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["rank"], name: "index_members_on_rank", unique: true
  end

  add_foreign_key "matches", "members", column: "black_player_id"
  add_foreign_key "matches", "members", column: "white_player_id"
end
