defmodule GameEngine.Game do
	use GenServer

	def start_link(opts \\ []) do
		GenServer.start_link(__MODULE__, [], opts)
	end

	def initialize(server, players) do
		GenServer.call(server, {:initialize, players})
	end

	def start(server, game_id, first_player) do
		GenServer.call(server, {:start, game_id, first_player})
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

	def handle_call({:initialize, %{o: %{name: o_name, type: o_type}, x: %{name: x_name, type: x_type}}}, _from, state) do
		game_id = GameEngine.GameIdGenerator.new

		type_of_game = get_type_of_game(o_type, x_type)
		
		GameEngine.Player.initialize(:o, o_name, o_type, :o, type_of_game)
		GameEngine.Player.initialize(:x, x_name, x_type, :x, type_of_game)
		

		state = %{game_id: game_id, 
				  status: :init,
				  type: type_of_game, 
				  board: %{},
				  o: o_name,
				  x: x_name}

		{:reply, {:ok, state}, state}
	end

	def handle_call({:start, game_id, first_player}, _from, state) do
		cond do
			state[:game_id] != game_id -> 
				{:reply, {:error, "Invalid game_id provided"}, state}

			!first_player_part_of_game?(state, first_player) ->
				{:reply, {:error, "Invalid first player provided, not part of the game"}, state}
		
			true ->
				next_player = get_next_player(state[:o], state[:x], first_player)

				state = %{state | board: %GameEngine.Board{}, status: :start}
				state =  Map.put(state, :next_player, next_player)
				
				{:reply, {:ok, %{board: %GameEngine.Board{}, next_player: first_player}}, state}
		end
	end

	def handle_call({:move, game_id}, _from, state) do
		{:ok, board_after_move} = GameEngine.Player.move(state[:next_player], state[:board])

		handle_move(state, board_after_move)
	end

	def handle_call({:move, game_id, move}, _from, state) do
		{:ok, board_after_move} = GameEngine.Player.move(state[:next_player], state[:board], move)

		handle_move(state, board_after_move)
	end

	defp get_type_of_game(:computer, :computer),  do: :computer_computer

	defp get_type_of_game(:human, :computer),  do: :human_computer

	defp get_type_of_game(:computer, :human),  do: :human_computer

	defp get_type_of_game(:human, :human),  do: :human_human

	defp first_player_part_of_game?(state, first_player) do
		state[:o] == first_player || state[:x] == first_player
	end

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

	defp get_next_player(o, x, first_player) when first_player == o, do: :o
	defp get_next_player(o, x, first_player) when first_player == x, do: :x

	defp get_player_name(:o, o, x), do: o
	defp get_player_name(:x, o, x), do: x
end