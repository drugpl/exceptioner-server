class CreateIssues < ActiveRecord::Migration
  def self.up
    create_table :issues do |t|
      t.string :name, :null => false
      t.text :message
      t.text :backtrace
      t.references :project, :null => false

      t.timestamps :null => false
    end
  end

  def self.down
    drop_table :issues
  end
end
