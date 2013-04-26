Feature: edit account

Scenario: Edit user account
	Given user is on dashboard page
	When user clicks on edit account in settings menu
	Then user should see edit user page
	
Scenario: Edit user account when user enters valid data
	Given user is on edit user account
	When user enters a valid data
	Then user account should get updated
	
Scenario:Do not edit account when user enters invalid email address
	Given user is on edit user account
	When user enters invalid email address
	Then user should see an error message for invalid email
	
Scenario: When user enters invalid current password
	Given user is on edit user account
	When user enters invalid current password while updating the profile
	Then user should see error message invalid password
	
Scenario: When user enters blank current password
	Given user is on edit user account
	When user keeps the current password field blank while updating the profile
	Then user should error message password cannot be blank


Scenario: Do not edit account when user enters password length less than expected
	Given user is on edit user account
	When user enters a password less than six characters
	Then user should see an error message password length small
	
Scenario: Do not edit account when user enters mismatch passwords while updating the password
	Given user is on edit user account
	When user enters mismatched passwords
	Then user should see an error message passwords do not match
	