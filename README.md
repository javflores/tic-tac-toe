# TicTacToe

Welcome to TicTacToe.

This TicTacToe allows us to play against a computer, or have two human players playing, or two computers playing against each other.
You can choose what player goes first. 
If a computer plays against a human, it will never lose and will win when playing against a not-perfect player.
To implement the intelligent player I have followed the algorithm described in [Wikipedia](https://en.wikipedia.org/wiki/Tic-tac-toe).

I have divided the solution in two parts: Game UI (client side) and GameEngine (server side).

## Game Engine

The GameEngine is an api-based application that you can use as stand-alone. You can integrate it with any client-side application (command line, web app).
I have provided detailed information on how to [get the GameEngine up and running] (https://github.com/javflores/tic-tac-toe/blob/master/game_engine/README.md).
It has been developed using Elixir language and Phoenix Framework, so that it makes a high reliable-fault tolerant app. I have enjoyed the goodnesses of Functional programming together with the power of the Erlang Virtual Machine.

## Game UI
The GameUI is a web application written in Javascript and running in NodeJS. It uses several technologies, being the more relevant one ReactJS.
I have provided detailed information on how to [get the GameUI up and running] (https://github.com/javflores/tic-tac-toe/blob/master/game_ui/README.md).

If you want to enjoy the full game experience, you can run both applications at the same time. And start playing straight away.
The power of Elixir together with ReactJS makes for a really performant application.

I have provided a few improvements that I'd like to implement for this solution.
Please don't hesitate to open a Github issue in this repository if you experience any issue.

I hope you enjoy it!
