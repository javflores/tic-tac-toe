defmodule GameEngine.EngineController do
	use GameEngine.Web, :controller

	def initialize(conn, params) do
		{:ok, setup} = GameEngine.Game.initialize(:game, get_players(params))
		
		conn
		|> json(handle_response(:init, setup))
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

	def move(conn, %{"game_id" => game_id, "move" => move}) do
		case GameEngine.Game.move(:game, game_id, parse_provided_move(move)) do
			{:winner, result} ->
				conn
				|> json(handle_response(:winner, game_id, result))
			{_, result} ->
				conn
				|> json(handle_response(:move, game_id, result))
		end
	end

	def move(conn, %{"game_id" => game_id}) do
		case GameEngine.Game.move(:game, game_id) do
			{:winner, result} ->
				conn
				|> json(handle_response(:winner, game_id, result))
			{_, result} ->
				conn
				|> json(handle_response(:move, game_id, result))
		end
	end	

	defp handle_response(:init, %{game_id: game_id, board: board, o: o, x: x, type: type}) do
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

	defp get_players(params) do
		o_name = params["o_name"]
		o_type = params["o_type"]
		x_name = params["x_name"]
		x_type = params["x_type"]
		
		%{o: %{name: o_name, type: String.to_atom(o_type)}, x: %{name: x_name, type: String.to_atom(x_type)}}
	end

	defp parse_provided_move(%{"row" => row, "column" => column}) do
		%{row: String.to_integer(row), column: String.to_integer(column)}
	end
end