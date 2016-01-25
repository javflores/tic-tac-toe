defmodule GameEngine.Engine do
	use GenServer

	def start_link(opts \\ []) do
		GenServer.start_link(__MODULE__, [], opts)
	end

	def initialize(server, type, o, x) do
		GenServer.call(server, {:initialize, type, o, x})
	end

	def start(server, game_id, first_player) do
		GenServer.call(server, {:start, game_id, first_player})
	end

	def move(server, game_id) do
		GenServer.call(server, {:move, game_id})
	end

	def init([]) do
		state = %{}
		{:ok, state}
	end

	def handle_call({:initialize, type, o, x}, _from, state) do
		game_id = GameEngine.GameIdGenerator.new
		new_game = %{game_id: game_id, board: %{}, o: o, x: x}

		state = %{game_id: new_game[:game_id], 
				  status: :init,
				  type: type, 
				  board: new_game[:board],
				  x: new_game[:x], 
				  o: new_game[:o]}

		{:reply, {:ok, new_game}, state}
	end

	def handle_call({:start, game_id, first_player}, _from, state) do
		cond do
			state[:game_id] != game_id -> 
				{:reply, {:error, "Invalid game_id provided"}, state}

			state[:o] != first_player && state[:x] != first_player ->
				{:reply, {:error, "Invalid first player provided, not part of the game"}, state}
		
			true ->
				%{state | board: %GameEngine.Board{}, next_player: first_player}
				{:reply, {:ok, %{board: %GameEngine.Board{}, next_player: first_player}}, state}
		end
	end
end