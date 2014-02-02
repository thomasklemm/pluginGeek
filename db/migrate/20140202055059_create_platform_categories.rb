class CreatePlatformCategories < ActiveRecord::Migration
  def change
    create_table :platform_categories do |t|
      t.belongs_to :platform, index: true
      t.belongs_to :category, index: true

      t.timestamps
    end

    add_index :platform_categories, [:platform_id, :category_id], unique: true
  end
end
