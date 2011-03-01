require 'acceptance/acceptance_helper'
include HelperMethods

feature "Projects" do
  background do
    @project = @website.has(:project, :user => @user.record)
  end

  scenario "should be visible only to authenticated users" do
    @user.visit(projects_path)
    @user.should_see_translated("sign_in")
    @user.visit(project_path(@project))
    @user.should_see_translated("sign_in")
    @user.sign_in
    @user.visit(projects_path)
    @user.should_not_see_translated("sign_in")
  end
end
