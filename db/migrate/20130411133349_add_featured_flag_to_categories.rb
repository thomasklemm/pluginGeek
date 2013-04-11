class AddFeaturedFlagToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :featured, :boolean, default: false
  end
end
