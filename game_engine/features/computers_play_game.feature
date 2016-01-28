Feature: Computer plays with computer
	As a game engine user, I can see how two computers play TicTacToe
	So that I can get some fun

	Scenario: Initialize game
		Given I select two computer players
		When I request to initialize the game
		Then I get a new initialized game

	Scenario: Start game
		Given I have initialized a new Computer vs Computer game
		When I choose to start the game with the first player
		Then I get a new started game

	Scenario: Computer move
		Given I have started a new Computer vs Computer game
		When I choose to get a computer to move
		Then I get the computers move
		And the game is in progress
