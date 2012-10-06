class AddParentsCountToRepos < ActiveRecord::Migration
  def up
    add_column :repos, :parents_count, :integer, default: 0

    Repo.reset_column_information

    Repo.find_each do |repo|
      Repo.update_counters repo.id, parents_count: repo.parents.length
    end
  end

  def down
    remove_column :repos, :parents_count
  end
end
