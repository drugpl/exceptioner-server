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
      @bob = @website.has(:user)
      @user.visit(project_path(@project))
      @user.should_see(@project.name)
      unowned_project = @website.has(:project, :user => @bob)
      @user.visit(project_path(unowned_project))
      @user.should_not_see(unowned_project.name)
    end

    scenario "should be editable only by owner" do
      new_name = "Modified project name"
      @bob = @website.has(:user)
      @user.visit(edit_project_path(@project))
      @user.should_see(@project.name)
      @user.fill_in("project_name", :with => new_name)
      @user.click_translated("projects.save")
      @user.should_see(new_name)
      unowned_project = @website.has(:project, :user => @bob)
      @user.visit(edit_project_path(unowned_project))
      @user.should_not_see(unowned_project.name)
    end

    scenario "should be deletable by owner" do
      @bob = @website.has(:user)
      @user.visit(projects_path)
      @user.click_translated('projects.delete')
      @user.should_not_see(@project.name)
    end

    scenario "should create new project" do
      @user.visit(projects_path)
      @user.should_see_translated('projects.owned')
      @user.click_translated('projects.new')
      @user.should_see(Project.human_attribute_name(:name))
      @user.fill_in("project_name", :with => "My very first project")
      @user.click_translated('projects.save')
      @user.should_see("My very first project")
    end

    scenario "should display an error after failed destroy" do
      Project.stub!(:exists?).and_return(true)
      @user.visit(projects_path)
      @user.click_translated('projects.delete')
      @user.should_see_translated('projects.actions.destroy.failed')
    end

    scenario "should display a message after successful destroy" do
      @user.visit(projects_path)
      @user.click_translated('projects.delete')
      @user.should_see_translated('projects.actions.destroy.successful')
    end

  end
end
