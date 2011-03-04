require 'token_generator'

class Project < ActiveRecord::Base
  belongs_to :user
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
