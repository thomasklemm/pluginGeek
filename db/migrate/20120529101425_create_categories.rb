class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.integer :repo_count, default: 0
      t.integer :watcher_count, default: 0
      t.integer :knight_score, default: 0
      t.text :short_description
      t.text :description
      t.text :md_description
      t.string :popular_repos
      t.text :all_repos


      t.timestamps
    end
    add_index :categories, :slug, unique: true
    add_index :categories, :knight_score
  end
end
