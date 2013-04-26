DatabaseCleaner.start

Given /^user tries to signup$/ do
  
   visit "/users/sign_up"
end

When /^user enters valid data$/ do
  password = Faker::Internet.user_name
  fill_in "user_name" , :with => Faker::Name.first_name
  fill_in "user_email", :with => Faker::Internet.email
  fill_in "user_password", :with => password
  fill_in "user_password_confirmation", :with => password
  click_button "Register"
end

Then /^signup should be success$/ do
  page.should have_content "Logged In"
end

When /^user leaves blank username$/ do
   password = Faker::Internet.user_name
  fill_in "user_name" , :with => ""
  fill_in "user_email", :with => Faker::Internet.email
  fill_in "user_password", :with => password
  fill_in "user_password_confirmation", :with => password
  click_button "Register"
end

Then /^user should get Name can't be blank$/ do
  page.should have_content "Name can't be blank"
end

Then /^signup should be unsuccessful$/ do
  page.should have_content "unsuccessfull"
end

When /^user leaves blank password$/ do
   password = Faker::Internet.user_name
  fill_in "user_name" , :with => Faker::Name.first_name
  fill_in "user_email", :with => Faker::Internet.email
  fill_in "user_password", :with => ""
  fill_in "user_password_confirmation", :with => password
  click_button "Register"
end

Then /^user should get Passwort has to be filled$/ do
  page.should have_content "Password has to be filled"
end

When /^user leaves blank confirmation password$/ do
   password = Faker::Internet.user_name
  fill_in "user_name" , :with => Faker::Name.first_name
  fill_in "user_email", :with => Faker::Internet.email
  fill_in "user_password", :with => password
  fill_in "user_password_confirmation", :with => ""
  click_button "Register"
end

When /^user password and confirmation password doesn't match$/ do
   password = Faker::Internet.user_name
  fill_in "user_name" , :with => Faker::Name.first_name
  fill_in "user_email", :with => Faker::Internet.email
  fill_in "user_password", :with => password
  fill_in "user_password_confirmation", :with => Faker::Name.first_name
  click_button "Register"
end

When /^user inputs password less then minimum digits$/ do 
   password = "1234"
  fill_in "user_name" , :with => Faker::Name.first_name
  fill_in "user_email", :with => Faker::Internet.email
  fill_in "user_password", :with => password
  fill_in "user_password_confirmation", :with => password
  click_button "Register"
end

When /^user inputs invalid email format$/ do
   password = Faker::Internet.user_name
  fill_in "user_name" , :with => Faker::Name.first_name
  fill_in "user_email", :with => Faker::Name.first_name
  fill_in "user_password", :with => password
  fill_in "user_password_confirmation", :with => password
  click_button "Register"
end

Then /^user should get Password has to be filled$/ do
  page.should have_content "Password has to be filled"
end

Then /^user should get passwords have to match$/ do
  page.should have_content "passwords have to match"
end

Then /^user should get Password is too short$/ do
  page.should have_content "Password is too short"
end

Then /^user should get Email is invalid$/ do
  page.should have_content "Email is invalid"
end

DatabaseCleaner.clean