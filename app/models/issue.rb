require 'digest/sha1'

class Issue < ActiveRecord::Base
  belongs_to :project

  before_create :get_fingerprint

  validates_presence_of :name, :project

  attr_protected :project_id

  def get_fingerprint
    self.fingerprint = Digest::SHA1.hexdigest( self.name.to_s +
                                               self.exception.to_s +
                                               self.message.to_s +
                                               self.backtrace.to_s +
                                               self.controller.to_s +
                                               self.env.to_s +
                                               self.transports.to_s
                                             )
  end
end
