class AddMissingIndexesOnAuthentications < ActiveRecord::Migration
  def self.up
    add_index :authentications, :user_id
  end

  def self.down
    remove_index :authentications, :user_id
  end
end
