defmodule GameEngine.EngineController do
	use GameEngine.Web, :controller

	def start(conn, params) do
		case GameEngine.Game.start(:game, get_players(params)) do
			{:ok, game} ->
				conn
				|> json(handle_response(:start, game))

			{:error, message} ->
				conn
				|> put_status(400)
				|> json(message)
		end
	end

	def move(conn, %{"game_id" => game_id, "move" => %{"row" => row, "column" => column}}) do
		case GameEngine.Game.move(:game, game_id, %{row: row, column: column}) do
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

	defp handle_response(:start, %{game_id: game_id, board: board, o: o, x: x, type: type, next_player: next_player}) do
		%{game_id: game_id,
		  status: :start,
		  type: type,
		  o: o,
		  x: x,
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
		first_player = params["first_player"]
		
		%{o: %{name: o_name, type: String.to_atom(o_type)}, x: %{name: x_name, type: String.to_atom(x_type)}, first_player: first_player}
	end
end