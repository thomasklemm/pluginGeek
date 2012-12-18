class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.string :slug
      t.integer :parent_id

      t.timestamps
    end

    add_index :languages, :slug, unique: true
  end
end
