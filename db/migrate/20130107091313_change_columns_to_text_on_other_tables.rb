class ChangeColumnsToTextOnOtherTables < ActiveRecord::Migration
  def up
    change_column :link_relationships, :linkable_type, :text
    change_column :language_classifications, :classifier_type, :text
    change_column :languages, :name, :text
    change_column :languages, :slug, :text
  end

  def down
    change_column :link_relationships, :linkable_type, :string
    change_column :language_classifications, :classifier_type, :string
    change_column :languages, :name, :string
    change_column :languages, :slug, :string
  end
end
