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

  it "should be hashed before save" do
    @issue.get_fingerprint
    @issue.fingerprint.should_not eq(nil)
  end

end
