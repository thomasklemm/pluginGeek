class ChangeColumnsOnAuthentications < ActiveRecord::Migration
  def up
    change_column :authentications, :provider, :text, null: false
    change_column :authentications, :uid, :text, null: false
  end

  alias_method :down, :up
end
