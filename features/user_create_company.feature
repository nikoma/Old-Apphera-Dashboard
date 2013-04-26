Feature: user company creation

Scenario: new user visits dashboard

Given new signed up user logs in
When user visits dashboard 
Then user should see create company form


Scenario: user creates company with valid data successfully

Given new signed up user logs in
When user fills create company form with valid data
Then success message should appear


Scenario: user should not be able to create company with blank name

Given new signed up user logs in
When user fills create company form with blank name 
Then name should not be blank message should appear



Scenario: user should not be able to create company with blank first name

Given new signed up user logs in
When user fills create company form with blank first name 
Then first name should not be blank message should appear


Scenario: user should not be able to create company with blank phone number
Given new signed up user logs in
When user fills create company form with blank phone number
Then phone number should not be blank message should appear




