# TicTacToe Game Engine

Welcome to the TicTacToe Game Engine, an Elixir Phoenix API that manages a TicTacToe, allowing any type of client and providing a common interface for them to play a game.

## Main Technology stack

* [Elixir]() is the main programming language. It uses the Erlang Virtual Machine so that the GameEngine is fault tolerant highly reliable.

* [Phoenix]() is a web environment for Elixir. It uses the standard MVC pattern.

## Getting up and running:

* Install Elixir  from the [Elixir downloads page](http://elixir-lang.org/install.html
 
* In a command line, run `mix deps.get` in order to install all required dependencies.

* Run `mix test` to run unit tests. 

* Run `mix acceptance` to execute acceptance tests. These are end to end api tests written in WhiteBread, making sure that the happy path works.

* Run `mix phoenix.server` to start the game engine. The engine should be accessible now in [`localhost:4000`](http://localhost:4000).

## How to use the Game Engine

### Start a game

GameEngine provides an endpoint to start a game. You need to do a POST request to the following endpoint:

```
http://localhost:4000/start
```

Including players and player to start (in the Payload of the request as JSON content):

```
{
  "o_name": "Juan", 
  "o_type": "human", 
  "x_name": "R2-D2", 
  "x_type": "computer", 
  "first_player": "C3-PO"
}
```

In that example we have provided the player that will play with *O* and "X" and its type (human or computer).

An example response will be in the form:

```
{
	"x": "R2-D2"
	"type": "human_computer"
	"status": "start"
	"o": "Juan"
	"next_player": "Juan"
	"game_id": "3d3e6d80-d403-11e5-998f-00059a3c7a00"
	"board":
		0:  null
		1:  null
		2:  null
		3:  null
		4:  null
		5:  null
		6:  null
		7:  null
		8:  null
}
```

We get the type of game ("human_computer", "computer_computer" or "human_human"). That is calculated based on the players assignment.
We also get a gameId that identifies this game and an initial board.

### Performing a move.

Game Engine provides a way to get a player to move.

You need to do a POST operation to the following endpoint:

```
http://localhost:4000/move/{game_id}
```

You need to provide the Id of a game that has already been started.

If the next player is a computer, GameEngine will calculate a move. Bear in mind that if a computer finds that it is playing against a human it will try to be a perfect player (aka as Kickass). So it should win or at least, don't lose.

If the next player is a human, you need to provide a move (in the Payload of the Request as JSON format) in the form:

```
{
  "move":{
    "row": 0,
    "column": 1
  }
}
```

The response will be in the form:

```
{
	"status": "in_progress"
	"player": "R2-D2"
	"next_player": "Juan"
	"game_id": "3a412ee0-d40a-11e5-b407-00059a3c7a00"
	"board":
		0:  null
		1:  null
		2:  null
		3:  null
		4:  "o"
		5:  null
		6:  null
		7:  null
		8:  null
}
```
We get from the Game Engine:

* The current board after the move.
* The player that performed the move.
* Next player to move.
* Status of the game. If the game is a draw we will get status = "draw" after a move. If a player has won the game we'll get status = "win" and the winner will be the player that performed the move.

## Code structure:

Game Engine is a traditional Phoenix application.

- Under **features** we have our Acceptance tests. We have choosen WhiteBread as our Gherkin-syntax acceptance tests framework. Due to the framework being a bit young, we found some issues when developing this app. We have covered the happy paths as edge cases are covered by unit tests.

- **test** contains our unit tests. In functional programming developers don't tend to mock things out since the code is inmutable, there won't be any side effects in other components that the given component uses. In our case since we have used Mock library to fake some components and helping designing the application while doing Test Driven Development.

- In **web** we have the routes defining the api and also the main MVC controller, *engine controller*. It receives any requests and process parameters, that get sent to the Game module. After the Game module process the request, the controller is responsible for building up the response for the request.

- **lib** is the core part of the application. It is mainly composed by:

 - *GameEngine* is the main Supervisor module of the application. It is responsible for starting a Game worker and also starting the Players Supervisor. If one of the child processes stops it will try to restart them.

 - *Game* is a GenServer module that stores the state of our game. It handles the requests from the controller to start a new game and performing moves. It does so by initializing a couple of Player processes that perform the moves.

 - *Player* is responsible for perfoming moves when there is an incoming request to move. When initializing a player they get a ** Play Strategy** on how to play, so the player is decoupled from how to play the game. We could even change the strategy at run time if the player finds that the opponent is playing smarter that it expected.

 - **PlayStrategies**: so far we support:

 	- *Simple Strategy* involving a player to make random moves.

 	- *KickAss* is our perfect-player strategy. It takes place once a computer is playing agains a human. **Kickass** uses the Chain of Responsibility pattern, obtaining a list of Commands and executing them until it gets a move from one of the Move strategies. We have used Elixir Behaviours so that Kickass doesn't need to worry about the concrete implementation of the different moves but rather the common interface for all of them.

 	-In *Moves* we have the different moves that comprise an intelligent player (taken from the Wikipedia).

 - **Board** module is the main referee of the game. It put marks given a players move and also informs about a winner.

## Feedback and issues:

We really appreciate your feedback. If you want to see some improvements in the app I'll be really grateful if you can drop me an email to *javicaria@ingenieros.com*.

Additionally, if you find any issue when running the app or any other other matter, please feel free to open an issue in [this Github repo](https://github.com/javflores/tic-tac-toe/issues).

## Further improvements:

This is our MVP version of the GameEngine. We wanted to follow **Start small** and **Fail fast** principles so we can get your feedback earlier and make changes that makes sense your you.

We have considered:

* Improve managing of error in the application and edge cases. So far we have pretty much cover the happy path and some simple edge cases.
* Having concurrent games. It'd be great if this Engine could manage several games happening at the same time. Imagine even a computer player able to play agains several human players.
* Further refactoring an improvements. Like implementing the Chain of Responsibility pattern by having moves as Command object, delegating to the next command if they can not process the requests.