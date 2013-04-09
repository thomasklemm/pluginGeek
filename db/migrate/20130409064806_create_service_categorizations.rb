class CreateServiceCategorizations < ActiveRecord::Migration
  def change
    create_table :service_categorizations do |t|
      t.belongs_to :service
      t.belongs_to :category

      t.timestamps
    end
    add_index :service_categorizations, :service_id
    add_index :service_categorizations, :category_id
  end
end
