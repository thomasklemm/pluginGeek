class AddLabelToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :label, :string
  end
end
