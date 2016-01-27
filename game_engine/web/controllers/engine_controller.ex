defmodule GameEngine.EngineController do
	use GameEngine.Web, :controller

	def initialize(conn, params) do
		type = params["type"]
		o = params["o"]
		x = params["x"]

		{:ok, setup} = GameEngine.Game.initialize(:game, String.to_atom(type), o, x)
		
		conn
		|> json(handle_response(:init, type, setup))
	end

	def start(conn, params) do
		game_id = params["game_id"]
		first_player = params["first_player"]

		case GameEngine.Game.start(:game, game_id, first_player) do
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

		case GameEngine.Game.move(:game, game_id) do
			{:winner, result} ->
				conn
				|> json(handle_response(:winner, game_id, result))
			{_, result} ->
				conn
				|> json(handle_response(:move, game_id, result))
		end		
	end

	defp handle_response(:init, type, %{game_id: game_id, board: board, o: o, x: x}) do
		%{game_id: game_id,
		  status: :init,
		  type: type,
		  board: board,
		  o: o,
		  x: x}
	end

	defp handle_response(:start, game_id, %{board: board, next_player: next_player}) do
		%{game_id: game_id,
		  status: :start,
		  board: Tuple.to_list(board.positions),
		  next_player: next_player}
	end

	defp handle_response(:move, game_id, %{status: status, board: board, player: player, next_player: next_player}) do
		%{game_id: game_id,
		  status: status,
		  player: player,
		  board: Tuple.to_list(board.positions),
		  next_player: next_player}
	end

	defp handle_response(:winner, game_id, %{status: status, winner: winner, board: board, player: player, next_player: next_player}) do
		%{game_id: game_id,
		  status: status,
		  winner: winner,
		  player: player,
		  board: Tuple.to_list(board.positions),
		  next_player: next_player}
	end
end