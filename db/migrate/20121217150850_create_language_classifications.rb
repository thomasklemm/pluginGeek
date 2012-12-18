class CreateLanguageClassifications < ActiveRecord::Migration
  def change
    create_table :language_classifications do |t|
      # indexing nullable columns is slower (in MySQL),
      # all columns in indexes should be not-null
      t.integer :language_id, null: false
      t.integer :classifier_id, null: false
      t.string :classifier_type, null: false

      t.timestamps
    end

    add_index :language_classifications, :language_id
    add_index :language_classifications, [:classifier_id, :classifier_type], name: 'index_language_classifications_on_classifier'
  end
end
