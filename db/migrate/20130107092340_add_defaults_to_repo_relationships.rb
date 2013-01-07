class AddDefaultsToRepoRelationships < ActiveRecord::Migration
  def up
    change_column :repo_relationships, :parent_id, :integer, null: false
    change_column :repo_relationships, :child_id, :integer, null: false
  end

  alias_method :down, :up
end
