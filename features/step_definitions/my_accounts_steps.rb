When /^user clicks on my account in settings menu$/ do
  visit '/accounts'
end

Then /^user should see my account page$/ do
  page.should have_content('My Account')
end

Given /^user is on edit my account page$/ do
  user_sign_in
  visit '/accounts'

end

When /^user click on edit link$/ do
  user_id
  visit '/accounts/'+@user_account_id+'/edit'
end

Then /^user should see a form to submit\/edit details$/ do
  page.should have_content('Contact person')
end

When /^user enters valid data on update page$/ do
  user_id
  visit '/accounts/'+@user_account_id+'/edit'
  fill_in "account_name", :with => "Demo Companyy"
  fill_in "account_firstname", :with => "Nikhil"
  fill_in "account_lastname", :with => "Muthal"
  fill_in "account_street", :with => "10 Downing Street"
  fill_in "account_state", :with => "London"
  fill_in "account_postalcode", :with => "411020"
  fill_in "account_phone", :with => "1234567"
end

Then /^user should see success message account updated successfully$/ do
  page.should have_content('Account updated successfully')
end

When /^user keeps the company name blank$/ do
  user_id
  visit '/accounts/'+@user_account_id+'/edit'
  fill_in "account_firstname", :with => "Nikhil"
  fill_in "account_lastname", :with => "Muthal"
  fill_in "account_street", :with => "10 Downing Street"
  fill_in "account_state", :with => "London"
  fill_in "account_postalcode", :with => "411020"
  fill_in "account_phone", :with => "1234567"
end

Then /^user should see error message company name cannot be blank$/ do
  page.should have_content('Name The Company name cannot be empty')
end

When /^user keeps first name blank$/ do
  user_id
  visit '/accounts/'+@user_account_id+'/edit'
  fill_in "account_name", :with => "Demo Company"
  fill_in "account_lastname", :with => "Muthal"
  fill_in "account_street", :with => "10 Downing Street"
  fill_in "account_state", :with => "London"
  fill_in "account_postalcode", :with => "411020"
  fill_in "account_phone", :with => "1234567"
end

Then /^user should see error message first name cannot be blank$/ do
  page.should have_content('First name cannot be blank')
end

When /^user keeps last name blank$/ do
  user_id
  visit '/accounts/'+@user_account_id+'/edit'
  fill_in "account_name", :with => "Demo company"
  fill_in "account_firstname", :with => "Nikhil"
  fill_in "account_street", :with => "10 Downing Street"
  fill_in "account_state", :with => "London"
  fill_in "account_postalcode", :with => "411020"
  fill_in "account_phone", :with => "1234567"
end

Then /^user should see error message last name cannot be blank$/ do
  page.should have_content('Last name cannot be blank')
end

When /^user keeps phone number blank$/ do
  user_id
  visit '/accounts/'+@user_account_id+'/edit'
  fill_in "account_name", :with => ""
  fill_in "account_firstname", :with => "Nikhil"
  fill_in "account_lastname", :with => "Muthal"
  fill_in "account_street", :with => "10 Downing Street"
  fill_in "account_state", :with => "London"
  fill_in "account_postalcode", :with => "411020"

end

Then /^user should see error message phone cannot be blank$/ do
  page.should have_content('Phone number cannot be blank')
end

private

def user_id

  user = User.find(:first, :conditions =>['email = ?', 'niko.manek@gmail.com'])
  @user_account_id = user.account_id.to_s

end 