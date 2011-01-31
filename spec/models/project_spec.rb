require 'spec_helper'

describe Project do
  before do
    @project = Factory.build(:project)  
  end

  it "should require name" do
    @project.name = nil
    @project.save
    @project.should have(1).error_on(:name)
  end
  
  it "should have unique name" do
    Factory(:project, :name => @project.name)
    @project.save
    @project.should have(1).error_on(:name)
  end

  context "#create" do
    it "should generate API token" do
      @project.save
      token = @project.api_token
      token.should_not be_nil
      @project.save
      @project.api_token.should == token
    end
  end
end
