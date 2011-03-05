require 'fingerprint_generator'

class Issue < ActiveRecord::Base
  FINGERPRINT_ATTRIBUTES =
    %w(name exception message backtrace controller env transports)

  belongs_to :project

  validates_presence_of :name, :project, :fingerprint

  before_validation :assign_fingerprint, :on => :create

  attr_protected :project_id

  protected
  def assign_fingerprint
    attr_values = FINGERPRINT_ATTRIBUTES.collect { |attr| self[attr].to_s }
    self.fingerprint = FingerprintGenerator.generate_fingerprint(*attr_values)
  end
end
