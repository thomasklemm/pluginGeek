class AddDraftToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :draft, :boolean, default: true
  end
end
