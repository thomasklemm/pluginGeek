class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :description
      t.string :popular_repos
      t.integer :count

      t.timestamps
    end
    add_index :categories, :name, unique: true
  end
end
