require 'digest/sha1'

class Issue < ActiveRecord::Base
  FINGERPRINT_ATTRIBUTES =
    %w(name exception message backtrace controller env transports)

  belongs_to :project

  validates_presence_of :name, :project

  attr_protected :project_id

  before_create  :generate_fingerprint

  protected
  def generate_fingerprint
    attr_values = FINGERPRINT_ATTRIBUTES.collect { |attr| self[attr].to_s }
    self.fingerprint = Digest::SHA1.hexdigest(attr_values.join)
  end
end
