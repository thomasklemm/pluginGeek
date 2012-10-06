class AddCategoryStatsColumns < ActiveRecord::Migration
  def change
    add_column :categories, :stars, :integer, default: 0
    add_column :categories, :repos_count, :integer, default: 0
  end
end
