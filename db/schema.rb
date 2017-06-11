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

ActiveRecord::Schema.define(version: 20170611000310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "meme_prices", force: :cascade do |t|
    t.integer  "meme_id"
    t.float    "price"
    t.date     "closing_date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "meme_prices", ["meme_id"], name: "index_meme_prices_on_meme_id", using: :btree

  create_table "memes", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "img"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "up",          default: 0
    t.integer  "down",        default: 0
    t.integer  "volume"
    t.integer  "user_id"
  end

  add_index "memes", ["user_id"], name: "index_memes_on_user_id", using: :btree

  create_table "transaction_logs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "meme_id"
    t.integer  "amt"
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "action"
  end

  add_index "transaction_logs", ["meme_id"], name: "index_transaction_logs_on_meme_id", using: :btree
  add_index "transaction_logs", ["user_id"], name: "index_transaction_logs_on_user_id", using: :btree

  create_table "user_holdings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "meme_id"
    t.integer  "amt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "buy_price"
  end

  add_index "user_holdings", ["meme_id"], name: "index_user_holdings_on_meme_id", using: :btree
  add_index "user_holdings", ["user_id"], name: "index_user_holdings_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",  null: false
    t.string   "encrypted_password",     default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.float    "balance",                default: 0.0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "meme_id"
    t.boolean "up"
  end

  add_index "votes", ["meme_id"], name: "index_votes_on_meme_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

  add_foreign_key "meme_prices", "memes"
  add_foreign_key "memes", "users"
  add_foreign_key "transaction_logs", "memes"
  add_foreign_key "transaction_logs", "users"
  add_foreign_key "user_holdings", "memes"
  add_foreign_key "user_holdings", "users"
  add_foreign_key "votes", "memes"
  add_foreign_key "votes", "users"
end
