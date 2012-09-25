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

ActiveRecord::Schema.define(:version => 20120925204114) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "slug",                              :null => false
    t.integer  "repo_count",         :default => 0
    t.integer  "watcher_count",      :default => 0
    t.integer  "knight_score",       :default => 0
    t.text     "short_description"
    t.text     "description"
    t.string   "popular_repos"
    t.text     "all_repos"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "label"
    t.string   "name_and_languages"
    t.integer  "languages"
    t.string   "name"
  end

  add_index "categories", ["knight_score"], :name => "index_categories_on_knight_score"
  add_index "categories", ["slug"], :name => "index_categories_on_slug", :unique => true

  create_table "categories_repos", :id => false, :force => true do |t|
    t.integer "repo_id"
    t.integer "category_id"
  end

  add_index "categories_repos", ["category_id"], :name => "index_categories_repos_on_category_id"
  add_index "categories_repos", ["repo_id", "category_id"], :name => "index_categories_repos_on_repo_id_and_category_id"
  add_index "categories_repos", ["repo_id"], :name => "index_categories_repos_on_repo_id"

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

  create_table "repos", :force => true do |t|
    t.string   "full_name",                               :null => false
    t.string   "owner"
    t.string   "name"
    t.integer  "watchers",             :default => 0
    t.integer  "forks",                :default => 0
    t.text     "description"
    t.string   "github_url"
    t.string   "homepage_url"
    t.integer  "knight_score",         :default => 0
    t.datetime "github_updated_at"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "label"
    t.string   "cached_category_list"
    t.boolean  "update_success",       :default => false
    t.integer  "languages"
  end

  add_index "repos", ["full_name"], :name => "index_repos_on_full_name", :unique => true
  add_index "repos", ["knight_score"], :name => "index_repos_on_knight_score"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

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
