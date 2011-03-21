require 'acceptance/acceptance_helper'
include HelperMethods

feature "Projects" do
  background do
    @project = @website.has(:project, :users => [@user.record])
  end

  scenario "should be visible only to authenticated users" do
    @user.visit(projects_path)
    @user.should_see_translated('sign_in')
    @user.visit(project_path(@project))
    @user.should_see_translated('sign_in')
    @user.sign_in
    @user.visit(projects_path)
    @user.should_not_see_translated('sign_in')
  end

  context "visited by signed in user" do
    before(:each) do
      @user.sign_in
    end

    scenario "should be able to create a new project" do
      project_name = "Test creating projects"
      @user.visit(projects_path)
      @user.should_see_translated('projects.new')
      @user.click_translated('projects.new')
      @user.should_see_translated('activerecord.attributes.project.name')
      @user.fill_in_translated('activerecord.attributes.project.name', :with => project_name)
      @user.click_translated('projects.save')
      @user.should_see(project_name)
    end

    scenario "should be accesible only by owner" do
      @bob = @website.has(:user)
      @user.visit(project_path(@project))
      @user.should_see(@project.name)
      unowned_project = @website.has(:project, :users => [@bob])
      @user.visit(project_path(unowned_project))
      @user.should_not_see(unowned_project.name)
    end

    scenario "should be editable only by owner" do
      new_name = "Modified project name"
      @bob = @website.has(:user)
      @user.visit(edit_project_path(@project))
      @user.should_see(@project.name)
      @user.fill_in("project_name", :with => new_name)
      @user.click_translated('projects.save')
      @user.should_see(new_name)
      unowned_project = @website.has(:project, :users => [@bob])
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
      @user.should_see_translated('activerecord.attributes.project.name')
      @user.fill_in("project_name", :with => "My very first project")
      @user.click_translated('projects.save')
      @user.should_see("My very first project")
    end

    scenario "should destroy a project and display a message" do
      @user.visit(projects_path)
      @user.click_translated('projects.delete')
      @user.should_see_translated('projects.actions.destroy.successful')
    end

    scenario "should display an error after failed destroy" do
      Project.stub!(:exists?).and_return(true)
      @user.visit(projects_path)
      @user.click_translated('projects.delete')
      @user.should_see_translated('projects.actions.destroy.failed')
    end

    scenario "owner should be able to add watcher to the project" do
      @bob = @website.has(:user)
      @user.visit(project_path(@project))
      @user.should_see_translated('projects.add_user')
      @user.click_translated('projects.add_user')
      @user.should_see(@project.name)
      @user.should_see_translated('activerecord.attributes.user.email')
      @user.fill_in("project_user_email", :with => @bob.email)
      @user.click_translated('projects.add_user')
      @user.should_see(@project.name, @bob.email)
      @user.should_see_translated('users.watchers')
    end
  end
end
