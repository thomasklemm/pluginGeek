class RemoveUnusedFieldsOnLinks < ActiveRecord::Migration
  def change
    remove_column :links, :author, :text
    remove_column :links, :author_url, :text
    remove_column :links, :published_at, :datetime
  end
end
