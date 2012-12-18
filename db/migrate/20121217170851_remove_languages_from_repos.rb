class RemoveLanguagesFromRepos < ActiveRecord::Migration
  def up
    remove_column :repos, :languages
  end

  def down
    add_column :repos, :languages, :integer, default: 0
  end
end
