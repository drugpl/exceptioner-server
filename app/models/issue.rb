class Issue < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :name, :project

  attr_protected :project_id
end
