Given /^user is on  accounts page$/ do
  user_sign_in
  visit '/accounts'
end

When /^user clicks on add venues button$/ do
  click_on('Add venues')
end

Then /^user should see a form to add venue$/ do
  page.should have_content('Add Venue')
end

Given /^user is on add venues page$/ do
  user_sign_in
  visit '/accounts'
  click_on('Add venues')
end

When /^user submits valid information to the venue form$/ do
  fill_in "organization_name", :with => "Carmel Pizza Company"
  fill_in "organization_street", :with => "2826 Jones St"
  fill_in "organization_street2", :with => "(between Jefferson St & Beach St)"
  fill_in "organization_postalcode", :with => "94133"
  fill_in "organization_state", :with => "CA"
  fill_in "organization_phone1", :with => "(619) 450-4786"
  fill_in "organization_phone2", :with => "(415) 676-1185"
  select("United States", :from => "country_code_id")
  fill_in "organization_city", :with => "California"
  fill_in "organization_category", :with => "Pizza"
  fill_in "organization_url", :with => "http://www.carmelpizzaco.com"
  click_button('Save')
end

Then /^user should see success message venue added successfully$/ do
  page.should have_content('Venue added successfully')
end

When /^user submits invalid or incorrect data$/ do
  fill_in "organization_name", :with => ""
  fill_in "organization_street", :with => ""
  fill_in "organization_street2", :with => "(between Jefferson St & Beach St)"
  fill_in "organization_postalcode", :with => "94133"
  fill_in "organization_state", :with => "CA"
  fill_in "organization_phone1", :with => "(619) 450-4786"
  fill_in "organization_phone2", :with => "(415) 676-1185"
  select("United States", :from => "country_code_id")
  fill_in "organization_city", :with => "California"
  fill_in "organization_category", :with => ""
  fill_in "organization_url", :with => ""
  click_button('Save')
end

Then /^user should see an error message venue cann not be added$/ do
  page.should have_content('Error while adding venues')
end

Given /^user is on add venue page$/ do
  user_sign_in
  visit '/accounts'
  click_on('Add venues')
end

When /^user keeps the name of the venue blank$/ do
  fill_in "organization_street", :with => "2826 Jones St"
  fill_in "organization_street2", :with => "(between Jefferson St & Beach St)"
  fill_in "organization_postalcode", :with => "94133"
  fill_in "organization_state", :with => "CA"
  fill_in "organization_phone1", :with => "(619) 450-4786"
  fill_in "organization_phone2", :with => "(415) 676-1185"
  select("United States", :from => "country_code_id")
  fill_in "organization_city", :with => "California"
  fill_in "organization_category", :with => "Pizza"
  fill_in "organization_url", :with => "http://www.carmelpizzaco.com"
  click_button('Save')
end

Then /^user should see an error message field Name is required$/ do
  page.should have_content('Field Name is required')
end

When /^user keeps the street field blank$/ do 
  fill_in "organization_name", :with => "Carmel Pizza Company"
  fill_in "organization_street2", :with => "(between Jefferson St & Beach St)"
  fill_in "organization_postalcode", :with => "94133"
  fill_in "organization_state", :with => "CA"
  fill_in "organization_phone1", :with => "(619) 450-4786"
  fill_in "organization_phone2", :with => "(415) 676-1185"
  select("United States", :from => "country_code_id")
  fill_in "organization_city", :with => "California"
  fill_in "organization_category", :with => "Pizza"
  fill_in "organization_url", :with => "http://www.carmelpizzaco.com"
  click_button('Save')
end

Then /^user should see an error message field Street is required$/ do
  page.should have_content('Field Street is required.')
end

When /^user keeps the postal code field blank$/ do
  fill_in "organization_name", :with => "Carmel Pizza Company"
  fill_in "organization_street2", :with => "(between Jefferson St & Beach St)"
  fill_in "organization_state", :with => "CA"
  fill_in "organization_phone1", :with => "(619) 450-4786"
  fill_in "organization_phone2", :with => "(415) 676-1185"
  select("United States", :from => "country_code_id")
  fill_in "organization_city", :with => "California"
  fill_in "organization_category", :with => "Pizza"
  fill_in "organization_url", :with => "http://www.carmelpizzaco.com"
  click_button('Save')
end

Then /^user should see an error message field Postal Code is required$/ do
  page.should have_content('Field Postal Code is required.')
end

When /^user keeps the phone field blank$/ do
  fill_in "organization_name", :with => "Carmel Pizza Company"
  fill_in "organization_street", :with => "2826 Jones St"
  fill_in "organization_street2", :with => "(between Jefferson St & Beach St)"
  fill_in "organization_postalcode", :with => "94133"
  fill_in "organization_state", :with => "CA"
  fill_in "organization_phone2", :with => "(415) 676-1185"
  select("United States", :from => "country_code_id")
  fill_in "organization_city", :with => "California"
  fill_in "organization_category", :with => "Pizza"
  fill_in "organization_url", :with => "http://www.carmelpizzaco.com"
  click_button('Save')
end

Then /^user should see an error message the field Phone is required$/ do
  page.should have_content('Field phone is required')
end

When /^user keeps the city field blank$/ do
  fill_in "organization_name", :with => "Carmel Pizza Company"
  fill_in "organization_street", :with => "2826 Jones St"
  fill_in "organization_street2", :with => "(between Jefferson St & Beach St)"
  fill_in "organization_postalcode", :with => "94133"
  fill_in "organization_state", :with => "CA"
  fill_in "organization_phone1", :with => "(415) 676-1185"
  fill_in "organization_phone2", :with => "(415) 676-1185"
  select("United States", :from => "country_code_id")
  fill_in "organization_category", :with => "Pizza"
  fill_in "organization_url", :with => "http://www.carmelpizzaco.com"
  click_button('Save')
end

Then /^user should see an error message the field City is required$/ do
  page.should have_content('Field city is required')
end

When /^user keeps the category field blank$/ do
  fill_in "organization_name", :with => "Carmel Pizza Company"
  fill_in "organization_street", :with => "2826 Jones St"
  fill_in "organization_street2", :with => "(between Jefferson St & Beach St)"
  fill_in "organization_postalcode", :with => "94133"
  fill_in "organization_state", :with => "CA"
  fill_in "organization_phone1", :with => "(415) 676-1185"
  fill_in "organization_phone2", :with => "(415) 676-1185"
  select("United States", :from => "country_code_id")
  fill_in "organization_city", :with => "California"
  fill_in "organization_url", :with => "http://www.carmelpizzaco.com"
  click_button('Save')
end

Then /^user should see an error message the field Category is required$/ do
  page.should have_content('Field category is required')
end
