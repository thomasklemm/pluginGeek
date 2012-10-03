class CreateCategoriesReposJoinTable < ActiveRecord::Migration
  def change
    create_table :categories_repos, id: false do |t|
      t.integer :repo_id
      t.integer :category_id
    end

    add_index :categories_repos, [:repo_id, :category_id], uniq: true
    # These seem to speed up lookups in some databases,
    # but not in MySQL for example which seems
    # to use only one index per table
    add_index :categories_repos, :repo_id
    add_index :categories_repos, :category_id
  end
end
