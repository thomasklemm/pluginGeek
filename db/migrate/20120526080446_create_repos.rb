class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string  :full_name
      t.string  :owner
      t.string  :name
      t.integer :watchers
      t.integer :forks
      t.string  :description
      t.string  :github_url
      t.string  :homepage_url
      t.integer :knight_grade

      t.datetime :github_updated_at
      t.timestamps
    end

    add_index :repos, :full_name, unique: true
  end
end
