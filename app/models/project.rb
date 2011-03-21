require 'token_generator'

class Project < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_one :owner, :class_name => "User", :foreign_key => "owner_id"
  has_many :issues, :dependent => :destroy

  validates_presence_of :name, :api_token
  validates_uniqueness_of :name

  before_validation :assign_api_token, :on => :create

  attr_accessible :name

  protected
  def assign_api_token
    self.api_token = TokenGenerator.generate_token
  end
end
