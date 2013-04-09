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

ActiveRecord::Schema.define(:version => 20130409064806) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.text     "provider",   :null => false
    t.text     "uid",        :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "categories", :force => true do |t|
    t.text     "slug",                            :null => false
    t.integer  "score",         :default => 0
    t.text     "description"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.text     "full_name",                       :null => false
    t.integer  "stars",         :default => 0
    t.boolean  "draft",         :default => true
    t.text     "repo_list"
    t.text     "language_list"
    t.integer  "repos_count",   :default => 0
  end

  add_index "categories", ["score"], :name => "index_categories_on_score"
  add_index "categories", ["slug"], :name => "index_categories_on_slug", :unique => true

  create_table "categorizations", :force => true do |t|
    t.integer "repo_id",     :null => false
    t.integer "category_id", :null => false
  end

  add_index "categorizations", ["category_id"], :name => "index_categorizations_on_category_id"
  add_index "categorizations", ["repo_id", "category_id"], :name => "index_categorizations_on_repo_id_and_category_id"
  add_index "categorizations", ["repo_id"], :name => "index_categorizations_on_repo_id"

  create_table "category_relationships", :force => true do |t|
    t.integer  "category_id"
    t.integer  "other_category_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "category_relationships", ["category_id"], :name => "index_category_relationships_on_category_id"
  add_index "category_relationships", ["other_category_id"], :name => "index_category_relationships_on_other_category_id"

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "language_classifications", :force => true do |t|
    t.integer  "language_id",     :null => false
    t.integer  "classifier_id",   :null => false
    t.text     "classifier_type", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "language_classifications", ["classifier_id", "classifier_type"], :name => "index_language_classifications_on_classifier"
  add_index "language_classifications", ["language_id"], :name => "index_language_classifications_on_language_id"

  create_table "language_hierarchies", :id => false, :force => true do |t|
    t.integer "ancestor_id",   :null => false
    t.integer "descendant_id", :null => false
    t.integer "generations",   :null => false
  end

  add_index "language_hierarchies", ["ancestor_id", "descendant_id"], :name => "index_language_hierarchies_on_ancestor_id_and_descendant_id", :unique => true
  add_index "language_hierarchies", ["descendant_id"], :name => "index_language_hierarchies_on_descendant_id"

  create_table "languages", :force => true do |t|
    t.text     "name"
    t.text     "slug"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "languages", ["slug"], :name => "index_languages_on_slug", :unique => true

  create_table "link_relationships", :force => true do |t|
    t.integer  "link_id",       :null => false
    t.integer  "linkable_id",   :null => false
    t.text     "linkable_type", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "link_relationships", ["link_id"], :name => "index_link_relationships_on_link_id"
  add_index "link_relationships", ["linkable_id", "linkable_type"], :name => "index_link_relationships_on_linkable"

  create_table "links", :force => true do |t|
    t.text     "url",          :null => false
    t.text     "title",        :null => false
    t.text     "author"
    t.text     "author_url"
    t.date     "published_at", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "submitter_id"
  end

  create_table "repo_relationships", :force => true do |t|
    t.integer  "parent_id",  :null => false
    t.integer  "child_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "repo_relationships", ["child_id"], :name => "index_repo_relationships_on_child_id"
  add_index "repo_relationships", ["parent_id", "child_id"], :name => "index_repo_relationships_on_parent_id_and_child_id", :unique => true
  add_index "repo_relationships", ["parent_id"], :name => "index_repo_relationships_on_parent_id"

  create_table "repos", :force => true do |t|
    t.text     "full_name",                             :null => false
    t.text     "owner"
    t.text     "name"
    t.integer  "stars",              :default => 0
    t.text     "github_description"
    t.text     "homepage_url"
    t.integer  "score",              :default => 0
    t.datetime "github_updated_at"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "update_success",     :default => false
    t.text     "description"
    t.boolean  "staff_pick",         :default => false
  end

  add_index "repos", ["full_name"], :name => "index_repos_on_full_name", :unique => true
  add_index "repos", ["score"], :name => "index_repos_on_score"

  create_table "service_categorizations", :force => true do |t|
    t.integer  "service_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "service_categorizations", ["category_id"], :name => "index_service_categorizations_on_category_id"
  add_index "service_categorizations", ["service_id"], :name => "index_service_categorizations_on_service_id"

  create_table "services", :force => true do |t|
    t.text     "name"
    t.text     "display_url"
    t.text     "target_url"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.text     "login",                                  :null => false
    t.text     "email"
    t.text     "name"
    t.text     "avatar_url"
    t.text     "location"
    t.text     "company"
    t.integer  "followers"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.text     "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "staff",               :default => false
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
