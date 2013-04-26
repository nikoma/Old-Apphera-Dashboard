Given /^user is logged in$/ do
  signin_and_create_company()
end

When /^user visits on review$/ do
 visit "/reviews"
end

Then /^user should get review listing page$/ do
  page.should have_content "Reviews"
end



private

def signin_and_create_company()
  sign_in()
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

