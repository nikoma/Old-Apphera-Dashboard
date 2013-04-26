Feature: Competitors

Scenario: User should get competitors list

Given user is logged in 
When user visits on competitors
Then user should get competitors listing page


Scenario: User should be able to add competitors 

Given user is logged in 
When user visits on competitors and clicks add competitors 
Then user should get add competitors form