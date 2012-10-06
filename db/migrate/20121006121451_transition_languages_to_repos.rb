class TransitionLanguagesToRepos < ActiveRecord::Migration
  def up
    Category.find_each(&:save)
    Repo.find_each(&:save)
  end

  def down
  end
end
