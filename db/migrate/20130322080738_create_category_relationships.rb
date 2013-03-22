class CreateCategoryRelationships < ActiveRecord::Migration
  def change
    create_table :category_relationships do |t|
      t.belongs_to :category
      t.belongs_to :other_category

      t.timestamps
    end
    add_index :category_relationships, :category_id
    add_index :category_relationships, :other_category_id
  end
end
