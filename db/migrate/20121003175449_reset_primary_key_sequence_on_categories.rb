class ResetPrimaryKeySequenceOnCategories < ActiveRecord::Migration
  def up
    # Delete all Categories
    Category.delete_all

    # Reset the primary key sequence of categories table
    ActiveRecord::Base.connection.reset_pk_sequence!(Category.table_name)

    # Delete all Slugs
    FriendlyId::Slug.delete_all

    # Reset the primary key sequence of slugs table
    ActiveRecord::Base.connection.reset_pk_sequence!(FriendlyId::Slug.table_name)
  end

  def down
    # Nothing to do here, will work multiple times, but cannot be totally undone
  end
end
