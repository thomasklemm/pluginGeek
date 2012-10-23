class AddLabelsAndPitchesForRepos < ActiveRecord::Migration
  def change
    # Repos
    #  -> Label in Categories
    #  -> Pitch in Categories
    add_column :repos, :lic, :string
    add_column :repos, :pic, :string
    #  -> Label in Overview
    #  -> Pitch in Overview
    add_column :repos, :lio, :string
    add_column :repos, :pio, :string
  end
end
