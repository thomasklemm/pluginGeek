class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string  :full_name, null: false
      t.string  :owner
      t.string  :name
      t.integer :watchers, default: 0
      t.integer :forks, default: 0
      t.text  :description
      t.string  :github_url
      t.string  :homepage_url
      t.integer :knight_score, default: 0

      t.datetime :github_updated_at
      t.timestamps
    end

    add_index :repos, :full_name, unique: true
    add_index :repos, :knight_score
  end
end
