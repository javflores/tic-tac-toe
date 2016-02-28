# TicTacToe Game UI

Welcome to the TicTacToe Game UI, a simple Javascript web application allowing users to interact with our Game Engine.
The goal of this project is to make possible for users to have a richer experience when playing TicTacToe.
Separating the Client from the Server side allows us to have a nicer separation of concerns and ease deployment of one part without having to deploy the other.

## Main Technology stack

* [NodeJS](https://nodejs.org/en/) for our web environment (GameUI has been developed using Node 5.5, but it should be compatible with version 4.x-5.x)

* [Hapi](http://hapijs.com/) is our web framework, providing easy configuration, definition of routes,...

* [SuperAgent](https://github.com/visionmedia/superagent) is a really small client-side HTTP requests library.

* [ReactRouter](https://github.com/reactjs/react-router) provides routing for our React-based application. ReactRouter makes sure that our routes and the state of the application always stay in sync.

* [Reflux](https://github.com/reflux/refluxjs) is our framework of choice to implement unidirectional dataflow architecture, Flux. 
Flux is an alternative to MVC patterns. MVC provides a bidirectional communication between layers in the application, so that one change in one of the layer cascades to the others.
This usually turns out into a cascade effect in the app, making the flow of our app hard to follow and difficult to debug and find issues.
Flux is all about controlling the flow of the app, if something happens in a View, it raises an Action that will be managed by a Store, and later any listeners will be able to update their state based on the result of the action.
Despite the many implementations of Flux available, Reflux turns to be the easier to get up and running.

* [ReactJS](https://facebook.github.io/react/) is a library created by Facebook to build user interfaces. We have chosen React because:
 * React allows us to break down our application into Components. Components use JSX, encapsulating the rendering part.
 * Components use state that will tell the component how to display. 
 * React uses a Virtual DOM, so having to rerender the component when state changes is still performing.
 * React provides hooks for the lifecycle events of the component, eg. *componentDidMount*, *render* or *componentDidUpdate*. 


## Getting up and running:

* You need Node running in your computer. We recommend version 4.x or above.
* When inside game-ui folder, in a command line run `npm install` to get all the required dependencies.
* Run `gulp`. This will *lintify* the code and it will create an application bundle file with the whole app. We are using [Babel](https://babeljs.io/) that enables us to write nicer ES2015 code that will be transpiled to native ES5 code 
* Run `npm test` to run the whole Unit tests suite. We have chosen Jest as our unit test framework. Since ReactJS wants a DOM to render the component, Jest uses JSDOM to create a fake DOM. It also mocks by default everything so that (in theory) you can focus on unit testing an isolated part.
* Run `node server` to start the application. You should be able to see the game ready in [http://localhost:8000/](http://localhost:8000/).
* Make sure you have the Game Engine running in [localhost:4000](http://localhost:4000).

## How to play

### Players selection

When the game is loaded, you need to select your players. You need to select the type of player you want by clicking in the dropdown, either *computer* or *human*.
You also can select the player that goes first by clicking in X or O players.

### Human versus Human.

If two human players have been selected, you just need to click in a position in the board to have the given player to play it. The current player will be highlighted in the panel below.

### Computer versus Computer.

If you want to see two computers playing, just select two computers in the player's selection step. Each computer will play in turns. In order to let the next player to move you simply need to click in the highlighted player in players panel.

Note: a computer will always be a perfect player.

### Human versus Computer.

If it is your turn, just click in the position you want to play in the board. After that the computer will perform its move. If you have selected the computer to start first, you will see its move straight away.

### Game over:

Once the game has a winner or there is a draw, you will see a dialog informing about the result. From here you can:

- Repeat the game with the same players selection.
- Start a new game.

## Feedback and issues:

We really appreciate your feedback. If you want to see some improvements in the app I'll be really grateful if you can drop me an email to *javicaria@ingenieros.com*.

Additionally, if you find any issue when running the app or any other other matter, please feel free to open an issue in [this Github repo](https://github.com/javflores/tic-tac-toe/issues).

## Further improvements:

This is our MVP version of the GameUI. We wanted to follow **Start small** and **Fail fast** principles so we can get your feedback earlier and make changes that makes sense your you.

We have considered:

* Using [Relay](https://facebook.github.io/relay/) will probably be a nice improvement for the application flow. Relay takes care of breaking down the different substores and notifying the relevant component.
* Using Mocha and JSDom seems to be the way to go for testing React. Jest mocks everything for you but that didn't necessarily means that things are easier to mock. We have had a not very easy time mocking Flux and Superagent.
* Some components could be broken down even further.