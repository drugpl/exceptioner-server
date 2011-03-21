class User < ActiveRecord::Base
  has_many :memberships
  has_many :projects, :through => :memberships
  has_many :owned_projects, :class_name => "Project"

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
end
