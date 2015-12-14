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

ActiveRecord::Schema.define(version: 20151214023324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.datetime "opt_in"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "email"
  end

  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id", using: :btree

  create_table "contacts_messages", id: false, force: :cascade do |t|
    t.integer "contacts_id"
    t.integer "messages_id"
  end

  add_index "contacts_messages", ["contacts_id"], name: "index_contacts_messages_on_contacts_id", using: :btree
  add_index "contacts_messages", ["messages_id"], name: "index_contacts_messages_on_messages_id", using: :btree

  create_table "destroys", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "directories", force: :cascade do |t|
    t.string   "phone_number"
    t.datetime "opt_in"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "directories", ["user_id"], name: "index_directories_on_user_id", using: :btree

  create_table "group_memberships", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "contact_id"
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "group_memberships", ["contact_id"], name: "index_group_memberships_on_contact_id", using: :btree
  add_index "group_memberships", ["group_id"], name: "index_group_memberships_on_group_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "type"
  end

  create_table "groups_messages", id: false, force: :cascade do |t|
    t.integer "groups_id"
    t.integer "messages_id"
  end

  add_index "groups_messages", ["groups_id"], name: "index_groups_messages_on_groups_id", using: :btree
  add_index "groups_messages", ["messages_id"], name: "index_groups_messages_on_messages_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "body"
    t.string   "to"
    t.string   "from"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "role"
    t.string   "email"
  end

  add_foreign_key "contacts", "users"
  add_foreign_key "directories", "users"
end
