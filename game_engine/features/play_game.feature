Feature: As a game engine user
	I can initialize a new game
	So that I can get everything ready

	Scenario: initialize Computer versus Computer game
		Given I select a Computer vs Computer game
		When I request to initialize the game
		Then I get a new initialized game