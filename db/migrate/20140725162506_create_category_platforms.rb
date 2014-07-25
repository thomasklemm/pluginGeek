class CreateCategoryPlatforms < ActiveRecord::Migration
  def change
    create_table :category_platforms do |t|
      t.string :platform_id
      t.integer :category_id
    end

    add_index :category_platforms, :platform_id
    add_index :category_platforms, :category_id
    add_index :category_platforms, [:platform_id, :category_id]
  end
end
