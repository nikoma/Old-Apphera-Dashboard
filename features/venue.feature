Feature: Venue

Scenario: User clicks on add venues button
	Given user is on  accounts page
	When user clicks on add venues button
	Then user should see a form to add venue
	
Scenario: Venue should get added when user submits all the valid information
	Given user is on add venues page
	When user submits valid information to the venue form
	Then user should see success message venue added successfully
	
Scenario: Venue should not be added when user submits invalid data
	Given user is on add venues page
	When user submits invalid or incorrect data 
	Then user should see an error message venue cann not be added
	
Scenario: Venue should not be added when the name is empty
	Given user is on add venues page
	When user keeps the name of the venue blank
	Then user should see an error message field Name is required
	
Scenario: Venue should not be added when address is blank
	Given user is on add venues page
	When user keeps the street field blank
	Then user should see an error message field Street is required
	
Scenario: Venue should not be added when the postal code field is blank
	Given user is on add venues page
	When user keeps the postal code field blank					
	Then user should see an error message field Postal Code is required

Scenario: Venue should not be added when the field phone is blank
	Given user is on add venues page
	When user keeps the phone field blank
	Then user should see an error message the field Phone is required

Scenario: Venue should not be added when the field city is blank
	Given user is on add venues page
	When user keeps the city field blank
	Then user should see an error message the field City is required

Scenario: Venue should not be added when the field category is blank
	Given user is on add venues page
	When user keeps the category field blank
	Then user should see an error message the field Category is required
	