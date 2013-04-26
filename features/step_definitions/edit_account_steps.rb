Given /^user is on dashboard page$/ do
  user_sign_in
end

When /^user clicks on edit account in settings menu$/ do
  visit '/users/edit'
end

Then /^user should see edit user page$/ do
  page.should have_content('Edit User')
end

Given /^user is on edit user account$/ do
  user_sign_in
  visit '/users/edit'
  @user = FactoryGirl.create(:user)
end

When /^user enters a valid data$/ do
  fill_in "user_name", :with => @user.name
  fill_in "user_email", :with => @user.email
  fill_in "user_current_password", :with => @user.password
  click_button('Update')
end

Then /^user account should get updated$/ do
  page.should have_content('User updated successfully')
end

When /^user enters invalid email address$/ do
  fill_in "user_name", :with => @user.name
  fill_in "user_email", :with => @user.name
  fill_in "user_current_password", :with => @user.password
  click_button('Update')
end

Then /^user should see an error message for invalid email$/ do
  ppage.should have_content('Invalid email address. Please enter a valid email.')
end

When /^user enters invalid current password while updating the profile$/ do
  fill_in "user_name", :with => @user.name
  fill_in "user_email", :with => @user.name
  fill_in "user_current_password", :with => "123456"
  click_button('Update')
end

Then /^user should see error message invalid password$/ do
  page.should have_content('Invalid password. Please enter valid password')
end

When /^user keeps the current password field blank while updating the profile$/ do
  fill_in "user_name", :with => @user.name
  fill_in "user_email", :with => @user.name
  
  click_button('Update')
end

Then /^user should error message password cannot be blank$/ do
  page.should have_content('Password cannot be blank')
end

When /^user enters a password less than six characters$/ do
  fill_in "user_name", :with => @user.name
  fill_in "user_email", :with => @user.name
  fill_in "user_current_password", :with => '12345'
  click_button('Update')
end

Then /^user should see an error message password length small$/ do
  page.should have_content('Password cannot be less than six characters')
end

When /^user enters mismatched passwords$/ do
  fill_in "user_name", :with => @user.name
  fill_in "user_email", :with => @user.name
  fill_in "user_password", :with => '123456'
  fill_in "user_password_confirmation", :with => '1234567'
  click_button('Update')
end

Then /^user should see an error message passwords do not match$/ do
  page.should have_content('Passwords do not match')
end

private

def user_sign_in
  
  visit '/users/sign_in'
  fill_in "user_email", :with => "niko.manek@gmail.com"
  fill_in "user_password", :with => "hallo123"
  click_button('Sign In')

end 