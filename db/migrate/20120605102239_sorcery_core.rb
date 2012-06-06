class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login,  :null => false
      t.string :email,  :default => nil
      t.string :name
      t.string :avatar_url
      t.string :github_url
      t.string :location
      t.string :company
      t.integer :followers
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end