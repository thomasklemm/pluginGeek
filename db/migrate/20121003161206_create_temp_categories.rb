class CreateTempCategories < ActiveRecord::Migration
  def change
    create_table :temp_categories do |t|
      t.string :name_and_languages
      t.text :short_description
      t.text :description

      t.timestamps
    end
  end
end
