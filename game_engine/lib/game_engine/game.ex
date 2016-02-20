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

	def handle_call({:start, %{o: o, x: x, first_player: first_player}}, _from, _state) do
		game_id = GameEngine.GameIdGenerator.new
		type_of_game = get_type_of_game(o, x)
		next_player = first_player

		GameEngine.Player.initialize(:o, o, :o, type_of_game)
		GameEngine.Player.initialize(:x, x, :x, type_of_game)

		state = %{game_id: game_id, 
				  status: :start,
				  type: type_of_game,
				  board: %GameEngine.Board{},
				  o: o,
				  x: x,
				  next_player: next_player}
				
		{:reply, {:ok, state}, state}
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
				response = Map.put(response, :winner, winner)
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
		player = :o
		next_player = :x

		{new_state, %{player: player, next_player: next_player, board: board_after_move}}
	end

	defp process_move(:x, board_after_move, current_state) do
		new_state = %{current_state | next_player: :o, board: board_after_move}
		player = :x
		next_player = :o

		{new_state, %{player: player, next_player: next_player, board: board_after_move}}
	end

	defp winner?({:winner, _winner}), do: true
	defp winner?({:no_winner}), do: false
end