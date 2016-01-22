Feature: As a game engine user
	I can initiate a new game
	So that I can get everything ready

	Scenario: Initiate Computer versus Computer game
		Given I select a Computer vs Computer game
		When I request to initiate the game
		Then I get a new initiated game