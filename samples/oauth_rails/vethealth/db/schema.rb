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

ActiveRecord::Schema.define(version: 2019_06_25_153052) do

  create_table "authentications", force: :cascade do |t|
    t.string "access_token"
    t.string "token_type"
    t.datetime "expires_at"
    t.string "scope"
    t.string "id_token"
    t.string "state"
    t.string "patient"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "oauth_callback_id"
    t.string "refresh_token"
    t.index ["oauth_callback_id"], name: "index_authentications_on_oauth_callback_id"
  end

  create_table "oauth_callbacks", force: :cascade do |t|
    t.boolean "verified_state"
    t.string "code"
    t.string "state"
    t.string "oauth_url"
    t.string "response_body_raw"
    t.integer "response_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
