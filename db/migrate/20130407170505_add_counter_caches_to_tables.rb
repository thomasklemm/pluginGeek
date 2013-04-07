class AddCounterCachesToTables < ActiveRecord::Migration
  def change
    add_column :categories, :repos_count, :integer, default: 0

    add_column :languages, :categories_count, :integer, default: 0
    add_column :languages, :repos_count, :integer, default: 0
  end
end
