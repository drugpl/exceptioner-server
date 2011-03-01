require 'spec_helper'

describe Project do
  before do
    @project = Factory.build(:project)
  end

  specify { @project.should be_valid }

  it "should require name" do
    @project.valid?
    @project.name = nil
    @project.should have(1).error_on(:name)
  end

  it "should have unique name" do
    Factory(:project, :name => @project.name)
    @project.should have(1).error_on(:name)
  end

  it "should generate API token" do
    @project.should be_valid
    @project.api_token.should be_present
  end

  it "should not allow to mass-assign API token" do
    fake_token = 'qwerty123'
    project = Factory.build(:project, :api_token => fake_token)
    @project.save
    @project.api_token.should_not == fake_token
  end

end
