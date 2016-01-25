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
				|> json(handle_response(:start, game_id, game))

			{:error, message} ->
				conn
				|> put_status(400)
				|> json(message)
		end
	end

	def move(conn, params) do
		game_id = params["game_id"]

		{:ok, result} = GameEngine.Engine.move(:engine, game_id)

		conn
		|> json(handle_response(:move, game_id, result))
	end

	defp handle_response(:init, type, %{game_id: game_id, board: board, o: o, x: x}) do
		%{game_id: game_id,
		  status: :init,
		  type: type,
		  board: board,
		  o: o,
		  x: x}
	end

	defp handle_response(:start, game_id, %{board: board, o: o, x: x}) do
		%{game_id: game_id,
		  status: :start,
		  board: Tuple.to_list(board.positions),
		  o: o,
		  x: x}
	end

	defp handle_response(:move, game_id, %{status: status, move: move, board: board}) do
		%{game_id: game_id,
		  status: status,
		  move: move,
		  board: Tuple.to_list(board.positions)}
	end
end