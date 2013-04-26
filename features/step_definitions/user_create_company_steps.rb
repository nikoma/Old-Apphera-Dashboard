Given /^new signed up user logs in$/ do
  sign_in()
end

When /^user visits dashboard$/ do
  visit "/"
end

Then /^user should see create company form$/ do
  page.should have_content "Please create a company"
end

When /^user fills create company form with valid data$/ do
  fill_in "account_name", :with => Faker::Company.name
  fill_in "account_firstname", :with => Faker::Name.first_name
  fill_in "account_lastname", :with => Faker::Name.last_name
  fill_in "account_street" , :with => Faker::Address.street_address
  fill_in "account_state", :with => Faker::Address.state
  fill_in "account_postalcode" , :with => Faker::Address.postcode
   select("United States", :from => "country_code_id")
  fill_in "account_phone" , :with => Faker::PhoneNumber.phone_number
  click_button "btn-save"
end

Then /^success message should appear$/ do
  page.should have_content "successfully"
end

When /^user fills create company form with blank name$/ do
  
  fill_in "account_firstname", :with => Faker::Name.first_name
  fill_in "account_lastname", :with => Faker::Name.last_name
  fill_in "account_street" , :with => Faker::Address.street_address
  fill_in "account_state", :with => Faker::Address.state
  fill_in "account_postalcode" , :with => Faker::Address.postcode
   select("United States", :from => "country_code_id")
  fill_in "account_phone" , :with => Faker::PhoneNumber.phone_number
  click_button "btn-save"
end

Then /^name should not be blank message should appear$/ do
  page.should have_content "Field Company Name is required."
end

When /^user fills create company form with blank first name$/ do
  fill_in "account_name", :with => Faker::Name.first_name
  
  fill_in "account_lastname", :with => Faker::Name.last_name
  fill_in "account_street" , :with => Faker::Address.street_address
  fill_in "account_state", :with => Faker::Address.state
  fill_in "account_postalcode" , :with => Faker::Address.postcode
   select("United States", :from => "country_code_id")
  fill_in "account_phone" , :with => Faker::PhoneNumber.phone_number
  click_button "btn-save"
end

Then /^first name should not be blank message should appear$/ do
  page.should have_content "Field First Name is required."
end

When /^user fills create company form with blank phone number$/ do
  fill_in "account_name", :with => Faker::Name.first_name
  fill_in "account_firstname", :with => Faker::Name.first_name
  fill_in "account_lastname", :with => Faker::Name.last_name
  fill_in "account_street" , :with => Faker::Address.street_address
  fill_in "account_state", :with => Faker::Address.state
  fill_in "account_postalcode" , :with => Faker::Address.postcode
   select("United States", :from => "country_code_id")
 
  click_button "btn-save"
end

Then /^phone number should not be blank message should appear$/ do
  page.should have_content "Field Phone is required."
end
