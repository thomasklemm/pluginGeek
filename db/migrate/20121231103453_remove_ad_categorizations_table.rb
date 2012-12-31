class RemoveAdCategorizationsTable < ActiveRecord::Migration
  def up
    drop_table :ad_categorizations
  end
end
