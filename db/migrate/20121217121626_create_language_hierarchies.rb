class CreateLanguageHierarchies < ActiveRecord::Migration
  def change
    create_table :language_hierarchies, id: false do |t|
      t.integer :ancestor_id,   null: false # Id of the parent/grandparent/great-grantparent ...
      t.integer :descendant_id, null: false # Id of the target language
      t.integer :generations,   null: false # Number of generations between the ancestor and the descendant. Parent/child = 1, for example.
    end

    # For "all progeny of ..." selects
    add_index :language_hierarchies, [:ancestor_id, :descendant_id], unique: true

    # For "all ancestors of ..." selects
    add_index :language_hierarchies, [:descendant_id]
  end
end
