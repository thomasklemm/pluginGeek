class CreateCategorizations < ActiveRecord::Migration

  class Categorization < ActiveRecord::Base; end

  def up
    rename_table :categories_repos, :categorizations
    add_column :categorizations, :id, :primary_key

    print 'Change associations for Repo and Category to has_many :through'
  end

  def down
    remove_column :categorizations, :id
    rename_table :categorizations, :categories_repos

    print 'Change associations for Repo and Category to has_and_belongs_to_many'
  end
end

# Inspiration: http://7fff.com/2007/10/31/activerecord-migrating-habtm-to-model-table-suitable-for-has_many-through/
