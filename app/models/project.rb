require 'token_generator'

class Project < ActiveRecord::Base
  has_many :project_users, :dependent => :destroy
  has_many :users, :through => :project_users
  has_many :issues, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :api_token

  before_validation :assign_api_token, :on => :create

  attr_accessible :name

  protected
  def assign_api_token
    self.api_token = TokenGenerator.generate_token
  end
end
