class AddLabelToRepos < ActiveRecord::Migration
  def change
    add_column :repos, :label, :string
  end
end
