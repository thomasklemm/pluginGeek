class ChangeColumnsOnUsers < ActiveRecord::Migration
  def up
    change_column :users, :avatar_url, :text
    change_column :users, :company, :text
    change_column :users, :email, :text
    change_column :users, :location, :text
    change_column :users, :login, :text
    change_column :users, :name, :text
    change_column :users, :github_url, :text
    change_column :users, :remember_me_token, :text
  end

  alias_method :down, :up
end
