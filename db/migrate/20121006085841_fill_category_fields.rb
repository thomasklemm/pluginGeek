class FillCategoryFields < ActiveRecord::Migration
  def up
    Category.find_each(&:save)
  end

  def down
    # Nothing to do here,
    # fields will be deleted with
    # the next migration down anyway
  end
end
