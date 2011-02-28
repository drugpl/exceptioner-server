require 'acceptance/acceptance_helper'
include HelperMethods

feature "Projects" do
  background do
    user = Factory(:user)
    project = Factory(:project, :user_id => user)
  end

  scenario "Show projets only to signed in users" do
    visit projects_path
    page.should have_content("Sign in")
    visit project_path(1)
    page.should have_content("Sign in")
    sign_in
    visit projects_path
    current_path.should == projects_path
  end
end
