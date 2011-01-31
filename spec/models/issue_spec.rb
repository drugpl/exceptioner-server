require 'spec_helper'

describe Issue do
  before do
    @issue = Factory.build(:issue)
  end

  it "should require name" do
    @issue.name = nil
    @issue.save
    @issue.should have(1).error_on(:name)
  end

  it "should require project" do
    @issue.project = nil
    @issue.save
    @issue.should have(1).error_on(:project)
  end
end
