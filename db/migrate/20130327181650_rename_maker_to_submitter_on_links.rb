class RenameMakerToSubmitterOnLinks < ActiveRecord::Migration
  def change
    rename_column :links, :maker_id, :submitter_id
  end
end
