Feature: Open a conference by clicking the conference name
	In order to register for the conference
	
Scenario: Open a valid conference page
	Given I am on the site home page
	When I click the "Test conference" link
	Then I should see a link with the text "Register" on the page