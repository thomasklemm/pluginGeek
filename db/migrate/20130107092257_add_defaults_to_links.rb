class AddDefaultsToLinks < ActiveRecord::Migration
  def up
    change_column :links, :url, :text, null: false
    change_column :links, :title, :text, null: false
    change_column :links, :published_at, :date, null: false
  end

  alias_method :down, :up
end
