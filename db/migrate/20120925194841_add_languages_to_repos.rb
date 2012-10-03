class AddLanguagesToRepos < ActiveRecord::Migration
  def change
    add_column :repos, :languages, :integer
  end
end
