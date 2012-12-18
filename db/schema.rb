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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121028211138) do

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "slug",                             :null => false
    t.integer  "knight_score",      :default => 0
    t.text     "short_description"
    t.text     "description"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "full_name",                        :null => false
    t.string   "name"
    t.integer  "stars",             :default => 0
    t.integer  "languages",         :default => 0
  end

  add_index "categories", ["knight_score"], :name => "index_categories_on_knight_score"
  add_index "categories", ["slug"], :name => "index_categories_on_slug", :unique => true

  create_table "categorizations", :force => true do |t|
    t.integer "repo_id"
    t.integer "category_id"
  end

  add_index "categorizations", ["category_id"], :name => "index_categories_repos_on_category_id"
  add_index "categorizations", ["repo_id", "category_id"], :name => "index_categories_repos_on_repo_id_and_category_id"
  add_index "categorizations", ["repo_id"], :name => "index_categories_repos_on_repo_id"

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "repo_relationships", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "child_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "repo_relationships", ["child_id"], :name => "index_repo_relationships_on_child_id"
  add_index "repo_relationships", ["parent_id"], :name => "index_repo_relationships_on_parent_id"

  create_table "repos", :force => true do |t|
    t.string   "full_name",                             :null => false
    t.string   "owner"
    t.string   "name"
    t.integer  "stars",              :default => 0
    t.text     "github_description"
    t.string   "github_url"
    t.string   "homepage_url"
    t.integer  "knight_score",       :default => 0
    t.datetime "github_updated_at"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "update_success",     :default => false
    t.text     "description"
    t.text     "label"
    t.integer  "languages",          :default => 0
  end

  add_index "repos", ["full_name"], :name => "index_repos_on_full_name", :unique => true
  add_index "repos", ["knight_score"], :name => "index_repos_on_knight_score"

  create_table "users", :force => true do |t|
    t.string   "login",                        :null => false
    t.string   "email"
    t.string   "name"
    t.string   "avatar_url"
    t.string   "github_url"
    t.string   "location"
    t.string   "company"
    t.integer  "followers"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
