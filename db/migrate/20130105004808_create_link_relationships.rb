class CreateLinkRelationships < ActiveRecord::Migration
  def change
    create_table :link_relationships do |t|
      t.integer :link_id,       null: false
      t.integer :linkable_id,   null: false
      t.string  :linkable_type, null: false

      t.timestamps
    end
    add_index :link_relationships, :link_id
    add_index :link_relationships, [:linkable_id, :linkable_type], name: 'index_link_relationships_on_linkable'
  end
end
