class RemoveLabelFromRepos < ActiveRecord::Migration
  def up
    remove_column :repos, :label
  end

  def down
    add_column :repos, :label, :string
  end
end
