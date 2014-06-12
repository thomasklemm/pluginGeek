class DropNotNullConstraintOnSomeColumns < ActiveRecord::Migration
  def change
    change_column_null :categorizations, :category_id, true
    change_column_null :categorizations, :repo_id, true

    change_column_null :link_relationships, :link_id, true
    change_column_null :link_relationships, :linkable_type, true
    change_column_null :link_relationships, :linkable_id, true

    change_column_null :links, :title, true

    change_column_null :repo_relationships, :parent_id, true
    change_column_null :repo_relationships, :child_id, true
  end
end
