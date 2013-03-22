class AddIndexOnCategorization < ActiveRecord::Migration
  def up
    remove_index :categorizations, name: "index_categories_repos_on_repo_id_and_category_id"
    add_index :categorizations, [:repo_id, :category_id], uniq: true
  end

  def down
    remove_index :categorizations, [:repo_id, :category_id], uniq: true
    add_index :categorizations, [:repo_id, :category_id]
  end
end
