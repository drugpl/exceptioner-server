class ChangeColumnUserIdInProjectsToOwnerId < ActiveRecord::Migration
  def self.up
    rename_column :projects, :user_id, :owner_id
  end

  def self.down
    rename_column :projects, :owner_id, :user_id
  end
end
