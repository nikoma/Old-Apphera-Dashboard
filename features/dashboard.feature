Feature: dashboard

Scenario: Logged in username should be visible

Given user logs into system
When user is on dashboard
Then user should see logged in link


Scenario: Logout link should be visible

Given user logs into system
When user is on dashboard
Then user should see logout link

Scenario: User should have settings link

Given user logs into system
When user is on dashboard
Then user should see settings link

Scenario: Choose organization should give organization data

Given user logs into system 
When user selects a organization on dashboard
Then user should see organization information

