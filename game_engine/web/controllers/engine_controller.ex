defmodule GameEngine.EngineController do
	use GameEngine.Web, :controller

	def initialize(conn, params) do
		type = params["type"]

		{:ok, setup} = GameEngine.Engine.initialize(:engine, type)
		
		conn
		|> json(handle_response(:init, type, setup))
	end

	def start(conn, params) do
		game_id = params["game_id"]

		case GameEngine.Engine.start(:engine, game_id) do
			{:ok, game} ->
				conn
				|> json(format_game(:start, game_id, game))

			{:error, message} ->
				conn
				|> put_status(400)
				|> json(message)
		end
	end

	defp handle_response(status, type, setup) do
		%{game_id: setup.game_id,
		  status: status,
		  type: type,
		  board: setup.board,
		  o: setup.o,
		  x: setup.x}
	end

	defp format_game(status, game_id, game) do
		%{game_id: game_id,
		  status: status,
		  board: Tuple.to_list(game.board.positions),
		  o: game.o,
		  x: game.x}
	end
end