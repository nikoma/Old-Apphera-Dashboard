Feature: user_signup


Scenario: Signup with valid data

 Given user tries to signup
 When user enters valid data
 Then signup should be success
 
Scenario: Sign up with blank username

  Given user tries to signup
  When user leaves blank username
  Then user should get Name can't be blank
  
Scenario: Sign up with blank password

  Given user tries to signup
  When user leaves blank password
  Then user should get Password has to be filled
  
Scenario: Sign up with blank confirmation password

  Given user tries to signup
  When user leaves blank confirmation password
  Then user should get passwords have to match  

Scenario: Sign up with non matching confirmation password

  Given user tries to signup
  When user password and confirmation password doesn't match
  Then user should get passwords have to match    
  
Scenario: Sign up with password less then 6 digits

  Given user tries to signup
  When user inputs password less then minimum digits
  Then user should get Password is too short   
  
Scenario: Sign up with invalid email format

  Given user tries to signup
  When user inputs invalid email format
  Then user should get Email is invalid

 

 