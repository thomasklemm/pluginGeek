class IndexRepoRelationshipsOnBothForeignKeys < ActiveRecord::Migration
  def change
    add_index :repo_relationships, [:parent_id, :child_id], unique: true
  end
end
