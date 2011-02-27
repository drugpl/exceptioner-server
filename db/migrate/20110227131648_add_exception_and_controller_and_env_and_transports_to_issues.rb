class AddExceptionAndControllerAndEnvAndTransportsToIssues < ActiveRecord::Migration
  def self.up
    add_column :issues, :exception, :string
    add_column :issues, :controller, :string
    add_column :issues, :env, :text
    add_column :issues, :transports, :text
  end

  def self.down
    remove_column :issues, :transports
    remove_column :issues, :env
    remove_column :issues, :controller
    remove_column :issues, :exception
  end
end
