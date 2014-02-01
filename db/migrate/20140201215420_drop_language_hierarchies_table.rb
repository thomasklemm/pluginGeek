class DropLanguageHierarchiesTable < ActiveRecord::Migration
  def change
    drop_table :language_hierarchies
  end
end
