Feature: Forgot password

Scenario: user forgot password
	Given user clicks on forgot password link
	When user clicks on the forgot password link
	Then user should see field to enter the email
	
Scenario: user enters valid email address
	Given user clicks on forgot password link
	When user enters a valid email address at forgot password page		
	Then user should see a success message an email has been sent with password reset instructions
	
	
Scenario: when user enters a valid email and the user does not exist in the system		
	Given user clicks on forgot password link
	When user enters a valid email address but the user does not exist in the system
	Then user should see an error message user does not exist in the system
		
Scenario: when user clicks on back to login
	Given user clicks on forgot password link
	When user clicks on back to login link
	Then user should be able to see sign in page
	
			
Scenario: when user clicks on signup
	Given user clicks on forgot password link
	When user clicks on sign up link
	Then user should see already have an account		