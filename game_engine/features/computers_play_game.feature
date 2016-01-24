Feature: As a game engine user
	I can see how two computers play TicTacToe
	So that I can get some fun

	Scenario: Initialize game
		Given I select a Computer vs Computer game
		When I request to initialize the game
		Then I get a new initialized game

	Scenario: Start game
		Given I have initialized a new Computer vs Computer game
		When I choose to start the game
		Then I get a new started game
