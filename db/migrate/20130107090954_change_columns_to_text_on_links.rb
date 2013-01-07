class ChangeColumnsToTextOnLinks < ActiveRecord::Migration
  def up
    change_column :links, :url, :text
    change_column :links, :title, :text
    change_column :links, :author, :text
    change_column :links, :author_url, :text
  end

  def down
    change_column :links, :url, :string
    change_column :links, :title, :string
    change_column :links, :author, :string
    change_column :links, :author_url, :string
  end
end
