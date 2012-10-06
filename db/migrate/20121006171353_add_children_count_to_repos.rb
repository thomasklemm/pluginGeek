class AddChildrenCountToRepos < ActiveRecord::Migration
  def up
    add_column :repos, :children_count, :integer, default: 0

    Repo.reset_column_information

    Repo.find_each do |repo|
      Repo.update_counters repo.id, children_count: repo.children.length
    end
  end

  def down
    remove_column :repos, :children_count
  end
end
