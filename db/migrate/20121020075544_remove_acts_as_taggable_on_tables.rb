class RemoveActsAsTaggableOnTables < ActiveRecord::Migration
  def up
    drop_table :taggings
    drop_table :tags
 end

  def down
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
  end
end
