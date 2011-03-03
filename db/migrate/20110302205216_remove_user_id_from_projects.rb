class RemoveUserIdFromProjects < ActiveRecord::Migration
  def self.up
    remove_column :projects, :user_id
  end

  def self.down
    add_column :projects, :user_id, :integer, :null => false
  end
end
