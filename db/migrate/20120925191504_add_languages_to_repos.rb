class AddLanguagesToRepos < ActiveRecord::Migration
  def change
    add_column :repos, :ruby, :boolean
    add_column :repos, :javascript, :boolean
    add_column :repos, :design, :boolean
  end
end
