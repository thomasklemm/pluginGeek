class TransitionParents < ActiveRecord::Migration
  def up
    Repo.find_each do |repo|
      repo.new_parent_list = repo.parent_list.join(', ')
      repo.save
    end
  end

  def down
    # One way only
    raise ActiveRecord::IrreversibleMigration, "One way only"
  end
end
