class RemoveDeprecatedColumnsFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :github_url
    remove_column :users, :remember_me_token
    remove_column :users, :remember_me_token_expires_at
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "User model needs to change, too."
  end
end
