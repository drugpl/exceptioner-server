class AddFingerprintToIssues < ActiveRecord::Migration
  def self.up
    add_column :issues, :fingerprint, :string
  end

  def self.down
    remove_column :issues, :fingerprint
  end
end
