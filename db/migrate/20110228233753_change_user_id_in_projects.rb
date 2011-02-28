class ChangeUserIdInProjects < ActiveRecord::Migration
  def self.up
    change_column :projects, :user_id, :integer, :null => false
  end

  def self.down
    change_column :projects, :user_id, :integer
  end
end
