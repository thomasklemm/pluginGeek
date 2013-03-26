class RenameKnightScoreToScoreEverywhere < ActiveRecord::Migration
  def change
    rename_column :repos, :knight_score, :score
    rename_column :categories, :knight_score, :score

    rename_index :repos, 'index_repos_on_knight_score', 'index_repos_on_score'
    rename_index :categories, 'index_categories_on_knight_score', 'index_categories_on_score'
  end
end
