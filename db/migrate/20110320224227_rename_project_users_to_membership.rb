class RenameProjectUsersToMembership < ActiveRecord::Migration
  def self.up
    rename_table :project_users, :memberships
  end

  def self.down
    rename_table :memberships, :project_users
  end
end
