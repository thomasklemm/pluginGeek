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

ActiveRecord::Schema.define(version: 20140725162506) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: true do |t|
    t.integer  "user_id",    null: false
    t.text     "provider",   null: false
    t.text     "uid",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "categories", force: true do |t|
    t.integer  "score",       default: 0
    t.text     "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "name",                        null: false
    t.integer  "stars",       default: 0
    t.boolean  "published",   default: false
    t.integer  "repos_count", default: 0
  end

  add_index "categories", ["repos_count"], name: "index_categories_on_repos_count", using: :btree
  add_index "categories", ["score"], name: "index_categories_on_score", using: :btree

  create_table "categorizations", force: true do |t|
    t.integer "repo_id"
    t.integer "category_id"
  end

  add_index "categorizations", ["category_id"], name: "index_categorizations_on_category_id", using: :btree
  add_index "categorizations", ["repo_id"], name: "index_categorizations_on_repo_id", using: :btree

  create_table "category_platforms", force: true do |t|
    t.string  "platform_id"
    t.integer "category_id"
  end

  add_index "category_platforms", ["category_id"], name: "index_category_platforms_on_category_id", using: :btree
  add_index "category_platforms", ["platform_id", "category_id"], name: "index_category_platforms_on_platform_id_and_category_id", using: :btree
  add_index "category_platforms", ["platform_id"], name: "index_category_platforms_on_platform_id", using: :btree

  create_table "category_relationships", force: true do |t|
    t.integer  "category_id"
    t.integer  "other_category_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "category_relationships", ["category_id"], name: "index_category_relationships_on_category_id", using: :btree
  add_index "category_relationships", ["other_category_id"], name: "index_category_relationships_on_other_category_id", using: :btree

  create_table "link_relationships", force: true do |t|
    t.integer  "link_id"
    t.integer  "linkable_id"
    t.text     "linkable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "link_relationships", ["link_id"], name: "index_link_relationships_on_link_id", using: :btree
  add_index "link_relationships", ["linkable_id", "linkable_type"], name: "index_link_relationships_on_linkable", using: :btree

  create_table "links", force: true do |t|
    t.text     "url",          null: false
    t.text     "title"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "submitter_id"
  end

  create_table "platforms", force: true do |t|
    t.text     "name",                         null: false
    t.text     "slug",                         null: false
    t.integer  "position",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "categories_count", default: 0
  end

  add_index "platforms", ["categories_count"], name: "index_platforms_on_categories_count", using: :btree
  add_index "platforms", ["slug"], name: "index_platforms_on_slug", unique: true, using: :btree

  create_table "repo_relationships", force: true do |t|
    t.integer  "parent_id"
    t.integer  "child_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "repo_relationships", ["child_id"], name: "index_repo_relationships_on_child_id", using: :btree
  add_index "repo_relationships", ["parent_id"], name: "index_repo_relationships_on_parent_id", using: :btree

  create_table "repos", force: true do |t|
    t.text     "owner_and_name",                    null: false
    t.integer  "stars",             default: 0
    t.text     "description"
    t.text     "homepage_url"
    t.integer  "score",             default: 0
    t.datetime "github_updated_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "staff_pick",        default: false
  end

  add_index "repos", ["owner_and_name"], name: "index_repos_on_owner_and_name", unique: true, using: :btree
  add_index "repos", ["score"], name: "index_repos_on_score", using: :btree
  add_index "repos", ["stars"], name: "index_repos_on_stars", using: :btree

  create_table "service_categorizations", force: true do |t|
    t.integer  "service_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "service_categorizations", ["category_id"], name: "index_service_categorizations_on_category_id", using: :btree
  add_index "service_categorizations", ["service_id"], name: "index_service_categorizations_on_service_id", using: :btree

  create_table "services", force: true do |t|
    t.text     "name"
    t.text     "display_url"
    t.text     "target_url"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: true do |t|
    t.text     "login",                               null: false
    t.text     "email"
    t.text     "name"
    t.text     "avatar_url"
    t.text     "location"
    t.text     "company"
    t.integer  "followers"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.text     "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "moderator",           default: false
  end

  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
