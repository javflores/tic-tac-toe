defmodule GameEngine.Engine do
	use GenServer

	def start_link(opts \\ []) do
		GenServer.start_link(__MODULE__, [], opts)
	end

	def initialize(server, type) do
		GenServer.call(server, {:initialize, type})
	end

	def start(server, game_id) do
		GenServer.call(server, {:start, game_id})
	end

	def move(server, game_id) do
		GenServer.call(server, {:move, game_id})
	end

	def init([]) do
		state = %{}
		{:ok, state}
	end

	def handle_call({:initialize, type}, _from, state) do
		game_id = GameEngine.GameIdGenerator.new
		new_game = %{game_id: game_id, board: %{}, x: nil, o: nil}

		state = %{game_id: new_game[:game_id], 
				  status: :init, 
				  type: type, 
				  board: new_game[:board],
				  x: new_game[:x], 
				  o: new_game[:o]}

		{:reply, {:ok, new_game}, state}
	end

	def handle_call({:start, game_id}, _from, state) do
		if state[:game_id] != game_id do
			{:reply, {:error, "Invalid game_id provided"}, state}
		else
			players = get_players(game_type_atom(state[:type]))

			%{state | board: %GameEngine.Board{}, o: players[:o], x: players[:x]}

			{:reply, {:ok, %{board: %GameEngine.Board{}, o: players[:o], x: players[:x]} }, state}
		end
	end

	defp get_players(:computer_computer) do
		%{o: :r2d2, x: :c3po}
	end

	defp game_type_atom(type) do
		String.to_atom(type)
	end

end