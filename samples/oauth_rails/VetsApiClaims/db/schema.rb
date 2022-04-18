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

ActiveRecord::Schema.define(version: 2019_10_04_153654) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "documents", force: :cascade do |t|
    t.string "guid"
    t.string "status"
    t.string "code"
    t.string "message"
    t.string "detail"
    t.string "location"
    t.string "username"
    t.integer "claim_ref"
    t.string "veteran_ref"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "access_token"
    t.string "token_type"
    t.datetime "expires_at"
    t.string "scope"
    t.string "id_token"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "refresh_token"
  end

  create_table "test_users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "ssn"
    t.date "birth_date"
    t.string "edipi"
    t.string "poa"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_veterans", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "ssn"
    t.date "birth_date"
    t.string "edipi"
    t.string "poa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "test_user_id"
    t.index ["test_user_id"], name: "index_test_veterans_on_test_user_id"
  end

end
