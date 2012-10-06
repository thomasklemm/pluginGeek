class TransitionLanguagesToRepos < ActiveRecord::Migration
  def up
    Repo.find_each(&:save)
  end

  def down
  end
end
