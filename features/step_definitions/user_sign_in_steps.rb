Given /^user tries to sign in$/ do
  visit '/users/sign_in'
end

When /^user enters valid user name and password$/ do
  fill_in "user_email", :with => "niko.manek@gmail.com"
  fill_in "user_password", :with => "hallo123"
  click_button('Sign In')
end

Then /^user should log in and able to see the logout link$/ do
  page.should have_content('Logout')
end

Given /^user enters a blank password$/ do
  visit '/users/sign_in'
end

When /^user tries to sign in with a blank password$/ do
  fill_in "user_email", :with => "niko.manek@gmail.com"
  click_button('Sign In')
end

Then /^user should see error an message for invalid password$/ do
  page.should have_content('Invalid/Blank password. Please enter a valid password ')
end

Given /^user enters a blank user name$/ do
  visit '/users/sign_in'
end

When /^user tries to sign in with a blank username$/ do
  fill_in "user_password", :with => "hallo123"
  click_button('Sign In')
end

Then /^user should see an error message for invalid username$/ do
  page.should have_content('Invalid/Blank username. Please enter a valid username ')
end

When /^user enters invalid user name and password$/ do
  fill_in "user_email", :with => "niko.manek@yahoo.com"
  fill_in "user_password", :with => "test123"
  click_button('Sign In')
end

Then /^user should see an error message$/ do
  page.should have_content('Invalid user name or password')
end