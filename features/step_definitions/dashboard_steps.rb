DatabaseCleaner.start

Given /^user logs into system$/ do
  sign_in()
  
end

When /^user is on dashboard$/ do
  page.should have_content "Dashboard"
end

Then /^user should see logged in link$/ do
  page.should have_content "Logged In As"
end

Then /^user should see logout link$/ do
  page.should have_content "Logout"
end

Then /^user should see settings link$/ do
  page.should have_content "Settings"
end

When /^user selects a organization on dashboard$/ do
 pending #select("1", :from => "organization[id]")
 
  
  page.select '1', :from => 'organization[id]'
  click_button "Chose organization"
end

Then /^user should see organization information$/ do
 pending
  page.should have_content "Quick overview for "
end

DatabaseCleaner.clean

private


 def sign_in()
  user = FactoryGirl.create(:user)
  visit '/users/sign_in'
  fill_in "user_email", :with => user.email
  fill_in "user_password", :with => user.password
  click_button('Sign In')
 end
 
