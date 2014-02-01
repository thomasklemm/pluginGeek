class DropLanguageClassificationsTable < ActiveRecord::Migration
  def change
    drop_table :language_classifications
  end
end
