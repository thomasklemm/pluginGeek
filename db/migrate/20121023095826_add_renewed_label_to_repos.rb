class AddRenewedLabelToRepos < ActiveRecord::Migration
  def change
    add_column :repos, :label, :text
  end
end
