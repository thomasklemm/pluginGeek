class TransitionNewCategories < ActiveRecord::Migration
  def up
    Repo.find_each do |r|
      r.new_category_list = r.category_list
    end
  end

  def down
    # Do nothing here, treat it as one way, but allow rollback
  end
end
