class AddDefaultsToCategorizations < ActiveRecord::Migration
  def up
    change_column :categorizations, :category_id, :integer, null: false
    change_column :categorizations, :repo_id, :integer, null: false
  end

  alias_method :down, :up
end
