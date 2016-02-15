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

### Player selection

- The first thing in order to play is to select your players. Please provide a name for each of your players and select the type of player you want, either *computer* or *human*. Click in the continue button when you are set.
- Select from the dropdown the player that will start first.

For next versions we will try to simplify this process. But we want to wait for you, user of our app, to have your important feedback before we do any further changes.

### Human versus Human.

If two human players have been selected, you just need to click in a position in the board to have the given player to play it. The current player will be highlighted in the panel below.

### Computer versus Computer.

If you want to see two computers playing, just select two computers in the player's selection step. Each computer will play in turns. In order to let the next player to move you simply need to click in the highlighted player in players panel.

Note: if a computer finds that it is playing against another computer, it can be really lazy, and probably you will see really lame distracted moves.

### Human versus Computer.

This changes things a lot. If you want to challenge the computer you will have to use all your [TicTacToe knowledge](https://en.wikipedia.org/wiki/Tic-tac-toe). The computer will play perfectly, it doesn't want to be defeated by a human.

If it is your turn, just click in the position you want to play in the board. After that the computer will perform its move. If you have selected the computer to start first, you will see its move straight away.

### Game over:

Once the game has a winner or there is a draw, you will see a dialog informing about the result. You can start a new game by clicking in the button in the dialog.

For next versions we are planning to improve this experience by allowing you to start the same game again so you don't have to the set up all over again.

## Code structure:

The app is composed by the following:

- **Gulpfile and gulp folder** define our automation tasks to build up the application. We found an issue when running Jest unit tests using gulp (gulp jest package is out of date and running npm with gulp-exec is not possible anymore with the latest version of Node).
Therefore you will see that unit tests are run using pure npm commands.

- **Server.js** is our main file, it is responsible for starting the app and listen to incoming requests.

- **__tests__** folder is where all our tests live. We are using Jest and by default this folder is where it searches for tests.

- **components folder** includes our React components and also our Flux actions and stores (game-requests folder). Additionally we have used some plugins including Bootstrap and Fontawesome.
 
 - **index.js** is all about managing the index route of our app. It renders our main component TicTacToe.
 
 - **tictactoe.js** contains our main component, responsible for rendering the main parts of our app, the **board**, the **players selections** and the **game over dialog**.
 
 - components will listen to relevant stores. For example, the **Board component** is connected to **Board store**, so that any time there is a change in the board, it will update its state.
 Any component can also raise an action. **Mark** component triggers a Move when it is clicked under certain conditions.
 
 - **Stores:** we have a main **GameStore** responsible for interacting with the **Game engine** by using super agent. We then have a bunch of sub stores that listen to GameStore. They provide a nice separation for components to listen to changes that are relevant for them.
 For example when a move is triggered and processed by **GameStore**, **ResultStore** is notified, it takes the result and notifies **GameOver** component with just that information.

- **Lib** is a folder created by our bundling process. This is where the transpiled code gets delivered and the code that the browser runs.

## Feedback and issues:

We really appreciate your feedback. If you want to see some improvements in the app I'll be really grateful if you can drop me an email to *javicaria@ingenieros.com*.

Additionally, if you find any issue when running the app or any other other matter, please feel free to open an issue in [this Github repo](https://github.com/javflores/tic-tac-toe/issues).

## Further improvements:

This is our MVP version of the GameUI. We wanted to follow **Start small** and **Fail fast** principles so we can get your feedback earlier and make changes that makes sense your you.

We have considered:

* Simplifying players selection process and other User Interface improvements.
* Using [Relay](https://facebook.github.io/relay/) will probably be a nice improvement for the application flow. Relay takes care of breaking down the different substores and notifying the relevant component.
* Using Mocha and JSDom seems to be the way to go for testing React. Jest mocks everything for you but that didn't necessarily means that things are easier to mock. We have had a not very easy time mocking Flux and Superagent.
* Some components could be broken down even further.