Given /^user clicks on forgot password link$/ do
  visit "/users/password/new"
end

When /^user clicks on the forgot password link$/ do
  visit "/users/password/new"
end

Then /^user should see field to enter the email$/ do
 page.should have_content('Email')
end

When /^user enters a valid email address at forgot password page$/ do
  fill_in "user_email", :with => Faker::Internet.email
  click_button('Send')
end

Then /^user should see a success message an email has been sent with password reset instructions$/ do
  page.should have_content('An email has been sent to you with reset passsword instructions')
end

When /^user enters a valid email address but the user does not exist in the system$/ do
  user = FactoryGirl.create(:user)
  email = Faker::Internet.email
  if user.email != email
    fill_in "user_email", :with => email
    click_button('Send')
  end  
end

Then /^user should see an error message user does not exist in the system$/ do
  page.should have_content('User with the email address does not exist')
end



When /^user clicks on back to login link$/ do
  click_link('Login')
end

Then /^user should be able to see sign in page$/ do
  page.should have_content('Sign In')
end


When /^user clicks on sign up link$/ do
  click_link('Sign up') 
end

Then /^user should see already have an account$/ do
  page.should have_content('Already have an account')
end
