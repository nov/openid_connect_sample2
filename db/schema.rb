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

ActiveRecord::Schema.define(version: 20160208063407) do

  create_table "access_tokens", force: :cascade do |t|
    t.integer  "authorization_id", null: false
    t.string   "token",            null: false
    t.datetime "expires_at",       null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["authorization_id"], name: "index_access_tokens_on_authorization_id"
    t.index ["token"], name: "index_access_tokens_on_token", unique: true
  end

  create_table "access_tokens_scopes", id: false, force: :cascade do |t|
    t.integer "access_token_id", null: false
    t.integer "scope_id",        null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.string   "identifier", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_accounts_on_identifier", unique: true
  end

  create_table "authorizations", force: :cascade do |t|
    t.integer  "account_id", null: false
    t.integer  "client_id",  null: false
    t.string   "code",       null: false
    t.string   "nonce"
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_authorizations_on_account_id"
    t.index ["client_id"], name: "index_authorizations_on_client_id"
    t.index ["code"], name: "index_authorizations_on_code", unique: true
  end

  create_table "authorizations_scopes", id: false, force: :cascade do |t|
    t.integer "authorization_id", null: false
    t.integer "scope_id",         null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "identifier",   null: false
    t.string   "secret",       null: false
    t.string   "redirect_uri", null: false
    t.string   "name",         null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["identifier"], name: "index_clients_on_identifier", unique: true
  end

  create_table "id_tokens", force: :cascade do |t|
    t.integer  "authorization_id", null: false
    t.string   "nonce"
    t.datetime "expires_at",       null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["authorization_id"], name: "index_id_tokens_on_authorization_id"
  end

  create_table "scopes", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_scopes_on_name", unique: true
  end

end
