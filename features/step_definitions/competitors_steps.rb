When /^user visits on competitors$/ do
  visit "/organizations"
end

Then /^user should get competitors listing page$/ do
 page.should have_content "Competitors"
end

When /^user visits on competitors and clicks add competitors$/ do
  visit "/organizations"
  
  click_on "Add Competitor"
end

Then /^user should get add competitors form$/ do
  page.should have_content "Add Competitor"
end