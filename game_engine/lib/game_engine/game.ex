defmodule GameEngine.Game do
	use GenServer

	def start_link(opts \\ []) do
		GenServer.start_link(__MODULE__, [], opts)
	end

	def start(server, players) do
		GenServer.call(server, {:start, players})
	end

	def move(server, game_id) do
		GenServer.call(server, {:move, game_id})
	end

	def move(server, game_id, move) do
		GenServer.call(server, {:move, game_id, move})
	end

	def init([]) do
		state = %{}
		{:ok, state}
	end

	def handle_call({:start, %{o: %{name: o_name, type: o_type}, x: %{name: x_name, type: x_type}, first_player: first_player}}, _from, _state) do
		game_id = GameEngine.GameIdGenerator.new

		type_of_game = get_type_of_game(o_type, x_type)

		GameEngine.Player.initialize(:o, o_name, o_type, :o, type_of_game)
		GameEngine.Player.initialize(:x, x_name, x_type, :x, type_of_game)

		next_player = get_next_player(o_name, x_name, first_player)

		state = %{game_id: game_id, 
				  status: :start,
				  type: type_of_game, 
				  board: %GameEngine.Board{},
				  o: o_name,
				  x: x_name,
				  next_player: next_player}
				
		{:reply, {:ok, %{state | next_player: get_player_name(next_player, o_name, x_name)}}, state}
	end

	def handle_call({:move, _game_id}, _from, state) do
		{:ok, board_after_move} = GameEngine.Player.move(state[:next_player], state[:board])

		handle_move(state, board_after_move)
	end

	def handle_call({:move, _game_id, move}, _from, state) do
		{:ok, board_after_move} = GameEngine.Player.move(state[:next_player], state[:board], move)

		handle_move(state, board_after_move)
	end

	defp get_type_of_game(:computer, :computer),  do: :computer_computer

	defp get_type_of_game(:human, :computer),  do: :human_computer

	defp get_type_of_game(:computer, :human),  do: :human_computer

	defp get_type_of_game(:human, :human),  do: :human_human

	defp handle_move(state, board_after_move) do
		{new_state, response} = process_move(state[:next_player], board_after_move, state)

		possible_winner = GameEngine.Board.resolve_winner(board_after_move)
		cond do
			winner?(possible_winner) ->
				{_, winner} = possible_winner
				new_state = %{new_state | status: :winner}
				response = Map.put(response, :status, :winner)
				response = Map.put(response, :winner, get_player_name(winner, new_state[:o], new_state[:x]))
				{:reply, {:winner, response}, new_state}

			GameEngine.Board.full?(board_after_move) ->
				new_state = %{new_state | status: :draw}
				response = Map.put(response, :status, :draw)
				{:reply, {:ok, response}, new_state}
			true ->
				new_state = %{new_state | status: :in_progress}
				response = Map.put(response, :status, :in_progress)
				{:reply, {:ok, response}, new_state}
		end
	end

	defp process_move(:o, board_after_move, current_state) do
		new_state = %{current_state | next_player: :x, board: board_after_move}
		player = get_player_name(:o, current_state[:o], current_state[:x])
		next_player = get_player_name(:x, current_state[:o], current_state[:x])

		{new_state, %{player: player, next_player: next_player, board: board_after_move}}
	end

	defp process_move(:x, board_after_move, current_state) do
		new_state = %{current_state | next_player: :o, board: board_after_move}
		player = get_player_name(:x, current_state[:o], current_state[:x])
		next_player = get_player_name(:o, current_state[:o], current_state[:x])

		{new_state, %{player: player, next_player: next_player, board: board_after_move}}
	end

	defp winner?({:winner, _winner}), do: true
	defp winner?({:no_winner}), do: false

	defp get_next_player(o, _x, first_player) when first_player == o, do: :o
	defp get_next_player(_o, x, first_player) when first_player == x, do: :x

	defp get_player_name(:o, o, _x), do: o
	defp get_player_name(:x, _o, x), do: x
end