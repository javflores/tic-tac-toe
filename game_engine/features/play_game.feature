Feature: Computer plays with computer
	As a game engine user, I can see how two computers play TicTacToe
	So that I can get some fun

	Scenario: Start game
		Given I select two computer players
		When I choose to start the game
		Then I get a new started game

	Scenario: Computer moves
		Given I have started a new Computer vs Computer game
		When I choose to get a computer to move
		Then I get the computers move
		And the game is in progress

Feature: Human versus computer game
	As a game engine user, I can play TicTacTo against a computer
	So that I can try to win

	Scenario: Computer moves after human
		Given I have started a human versus computer game
		When I provide the human player move
		Then I get the human player move
		When I choose to get a computer to move
		Then I get the computer opponent move

Feature: Human versus human game
	As a game engine user, I can play TicTacTo against a human
	So that I have more chances to win since we belong to the same species

	Scenario: Human moves after human
		Given I have started a human versus human game
		When I provide first human move
		Then I get the first human player move
		When I provide second human move
		Then I get the second human move
