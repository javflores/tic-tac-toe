Feature: As a game engine user
	I can play a new game

	Scenario: Initialize Computer versus Computer game
		Given I select a Computer vs Computer game
		When I request to initialize the game
		Then I get a new initialized game

	Scenario: Start Computer versus Computer game
		Given I have initialized a new Computer vs Computer game
		When I choose to start the game
		Then I get a new started game Computer vs Computer game