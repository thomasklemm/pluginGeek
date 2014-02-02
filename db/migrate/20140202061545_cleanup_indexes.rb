class CleanupIndexes < ActiveRecord::Migration
  def change
    add_index :platforms, :slug, unique: true

    add_index :repos, [:owner, :name]
    add_index :repos, :stars

    remove_index :categorizations, [:repo_id, :category_id]
    remove_index :repo_relationships, [:parent_id, :child_id]
  end
end
