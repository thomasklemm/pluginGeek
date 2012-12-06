class AddKeywordToAds < ActiveRecord::Migration
  def change
    add_column :ads, :keyword, :string
  end
end
