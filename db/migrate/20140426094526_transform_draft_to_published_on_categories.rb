class TransformDraftToPublishedOnCategories < ActiveRecord::Migration
  def up
    rename_column :categories, :draft, :published
    change_column :categories, :published, :boolean, default: false

    toggle_published_on_categories
  end

  def down
    rename_column :categories, :published, :draft
    change_column :categories, :draft, :boolean, default: true

    toggle_published_on_categories
  end

  private

  def toggle_published_on_categories
    Category.find_each do |category|
      category.update(published: !category.published)
    end
  end
end
