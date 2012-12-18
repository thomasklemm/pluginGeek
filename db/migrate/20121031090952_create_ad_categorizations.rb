class CreateAdCategorizations < ActiveRecord::Migration
  def change
    create_table :ad_categorizations, force: true do |t|
      t.belongs_to :category
      t.belongs_to :ad

      t.timestamps
    end
    add_index :ad_categorizations, :category_id
    add_index :ad_categorizations, :ad_id
  end
end
