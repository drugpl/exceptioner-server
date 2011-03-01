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

  context "visited by signed in user" do
    before(:each) do
      @user.sign_in
    end

    scenario "should be accesible only by owner" do
      pending "FIXME"
      @bob = @website.has(:user)
      @user.visit(project_path(@project))
      @user.should_see(@project.name)
      unowned_project = @website.has(:project, :user => @bob)
      @user.visit(project_path(unowned_project))
      @user.should_not_see(unowned_project.name)
    end
  end

end
