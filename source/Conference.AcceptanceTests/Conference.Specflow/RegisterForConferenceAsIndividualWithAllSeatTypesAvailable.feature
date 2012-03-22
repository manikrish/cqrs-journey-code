Feature: End-to-End process of self-registering for a conference by a registrant
	In order to attend conference
	As an attendee
	I want to be able to register for the Conference, pay for the registration order and associate myself with the paid order automatically

#	1. identify the conference
#	2. select seat types to register for
#	3. proceed to checkout
#	4. verify all order details and the total amount
#	5. pay
#	6. receive a confirmation message on screen (quickly)
#	7. receive a confirmation message on via email (could be delayed)

#note make sure to include the confirmation step as the registrant is also an attendee


Scenario: View seat types for a given conference
	Given I am on the CQRS summit 2012 conference site
	When I proceed to registration
	Then I should see the following details
	| seat type                        | rate |
	| General admission                | $199 |
	| Pre-con Workshop with Greg Young | $500 |
	| Additional cocktail party        | $50  |


#Note: seat types that are sold out should be clearly marked so! (either not shown, or grayed out or with tag "Sold Out!'

Scenario: Make a registration order selection
	Given the list of 3 seat types for the CQRS summit 2012 conference
	When I select 1 General admission seat
	And I select 1 Additional cocktail party seat
	Then I should see the total of $249
	And I should be able to proceed to Checkout


Scenario: Checkout
	Given the confirmed seats selection and the total amount
	And the time now is 12:00:00
	When I proceed to Checkout
	And I enter the registration details including name John Smith and email address John@smith.com
	Then I should be able to proceed to Payment
	And I should see the countdown at 15:00 minutes


Scenario: Payment
	Given the confirmed seats selection and the total amount
	And the time now is 12:00:00
	When I give payment details 
	And I proceed to confirm payment
	Then I receive confirmation message from payment
	
Scenario: ConfirmSeats
Given the payment is confirmed
Then I should receive confirmation with order number message on screen instantly
And I should receive message 'You will receive email regarding your registration shortly'
	
	#where will the user confirm the seats 

#Scenario: Countdown
#	Given I am back to Editing order details
#	When the time now is 12:05:00
 #   And I should see the countdown at 10:00 minutes

 #partial cancellation
	
	
