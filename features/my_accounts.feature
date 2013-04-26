Feature: my account

Scenario: My account info
	Given user is on dashboard page
	When user clicks on my account in settings menu
	Then user should see my account page

Scenario: Edit account info page
	Given user is on edit my account page
	When user click on edit link
	Then user should see a form to submit/edit details
		
Scenario: Edit my account info
	Given user is on edit my account page
	When user enters valid data on update page
	Then user should see success message account updated successfully

Scenario: Should not edit account when company name is blank
	Given user is on edit my account page
	When user keeps the company name blank
	Then user should see error message company name cannot be blank 
	
Scenario: Should not edit account when first name is blank
	Given user is on edit my account page
	When user keeps first name blank
	Then user should see error message first name cannot be blank		
	
Scenario: Should not edit account when last name is blank
	Given user is on edit my account page
	When user keeps last name blank 
	Then user should see error message last name cannot be blank
	
Scenario: should not edit account when phone is blank
	Given user is on edit my account page
	When user keeps phone number blank
	Then user should see error message phone cannot be blank
		