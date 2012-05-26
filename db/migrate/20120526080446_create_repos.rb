class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :owner
      t.string :name
      t.string :watchers
      t.string :forks
      t.string :description
      t.string :github_url
      t.string :homepage_url

      t.timestamps
    end
  end
end
