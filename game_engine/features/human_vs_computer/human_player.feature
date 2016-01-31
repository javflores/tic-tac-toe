Feature: Human versus computer game
	As a game engine user, I can play TicTacTo against a computer
	So that I can try to win

	Scenario: Human moves
		Given I have started a human versus computer game
		When I provide the human player move
		Then I get the human player move