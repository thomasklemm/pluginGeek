class AddPlatformIdsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :platform_ids, :string, array: true, default: []
    add_index :categories, :platform_ids, using: 'gin'
  end
end
