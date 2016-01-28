defmodule GameEngine.Player do
	use GenServer

	def start_link(opts \\ []) do
		GenServer.start_link(__MODULE__, [], opts)
	end

	def initialize(server, name, mark, game_type) do
		GenServer.call(server, {:initialize, name, mark, game_type})
	end

	def move(server, board) do
		GenServer.call(server, {:move, board})
	end

	def init([]) do
		state = %{}
		{:ok, state}
	end

	def handle_call({:initialize, name, mark, :computer_computer}, _from, state) do
		state = %{name: name, mark: mark, strategy: :simple}

		{:reply, {:ok, state}, state}
	end

	def handle_call({:move, board}, _from, state) do
		strategy = state[:strategy]
		mark = state[:mark]

		position = play(strategy, board)

		board = GameEngine.Board.put_mark(board, position, mark)

		{:reply, {:ok, board}, state}
	end

	defp play(:simple, board), do: GameEngine.SimpleStrategy.calculate_move(board)
end