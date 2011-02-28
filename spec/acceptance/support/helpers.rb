module HelperMethods
  # Put helper methods you need to be available in all tests here.
  def sign_in
    user = Factory(:user)
    visit new_user_session_path
    fill_in("Email", :with => "rubist1@drug.org.pl")
    fill_in("Password", :with => "mysecretpassword")
    click_button('Sign in')
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
