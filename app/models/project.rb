require 'token_generator'

class Project < ActiveRecord::Base
  include TokenGenerator

  has_many :issues

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :api_token, :unless => :new_record?

  before_create :assign_api_token

  def assign_api_token
    self.api_token = generate_token
  end
end