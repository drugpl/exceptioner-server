require 'spec_helper'
require 'digest/sha1'

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

  it "should require fingerprint" do
    @issue.should be_valid
    @issue.fingerprint.should be_present
  end

  context "#fingeprint" do
    it "should be generated before save" do
      @issue.save
      @issue.fingerprint.should be_present
    end

    it "should be identical for indentical attributes" do
      params = { :name => "RuntimeError", :message => "EOF" }
      @issue.update_attributes(params)
      duplicate = Factory(:issue, params)
      @issue.fingerprint.should == duplicate.fingerprint
    end

    it "should be different for different attributes" do
      params = { :name => "RuntimeError", :message => "EOF" }
      @issue.update_attributes(params)
      almost_duplicate = Factory(:issue, params.except(:message))
      @issue.fingerprint.should_not == almost_duplicate.fingerprint
    end
  end
end
