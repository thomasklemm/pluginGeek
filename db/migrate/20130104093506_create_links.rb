class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.string :title
      t.string :author
      t.string :author_url
      t.date :published_at

      t.timestamps
    end
  end
end
