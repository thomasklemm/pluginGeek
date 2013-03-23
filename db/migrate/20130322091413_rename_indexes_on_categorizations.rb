class RenameIndexesOnCategorizations < ActiveRecord::Migration
  def up
    remove_index :categorizations, name: 'index_categories_repos_on_repo_id'
    remove_index :categorizations, name: 'index_categories_repos_on_category_id'

    add_index :categorizations, :repo_id
    add_index :categorizations, :category_id
  end

  def down
  end
end
