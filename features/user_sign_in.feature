Feature: user_sign_in

Scenario: User tries to sign in
Given user tries to sign in
	When user enters valid user name and password
	Then user should log in and able to see the logout link
	
Scenario: User tries to sign in with blank password
Given user enters a blank password
	When user tries to sign in with a blank password
	Then user should see error an message for invalid password
	
Scenario: User tries to sign in with blank user name
Given user enters a blank user name
	When user tries to sign in with a blank username
	Then user should see an error message for invalid username
	
Scenario: User tries to sign in with invalid credentials
Given user tries to sign in
	When user enters invalid user name and password
	Then user should see an error message	