class RemoveRepoCacheColumns < ActiveRecord::Migration
  def up
    remove_column :repos, :cached_child_list
    remove_column :repos, :cached_language_list
  end

  def down
    add_column    :repos, :cached_child_list, :string
    add_column    :repos, :cached_language_list, :string
  end
end
