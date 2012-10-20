class AddMissingIndexesOnRepoRelationships < ActiveRecord::Migration
  def self.up
    add_index :repo_relationships, :parent_id
    add_index :repo_relationships, :child_id
  end

  def self.down
    remove_index :repo_relationships, :parent_id
    remove_index :repo_relationships, :child_id
  end
end
