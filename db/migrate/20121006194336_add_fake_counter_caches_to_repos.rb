class AddFakeCounterCachesToRepos < ActiveRecord::Migration
  def change
    # Fake to check Rails bug
    add_column :repos, :parentz_count, :integer, default: 0
    add_column :repos, :childrenz_count, :integer, default: 0
  end
end
