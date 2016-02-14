defmodule GameEngine.Player do
	use GenServer

	def start_link(opts \\ []) do
		GenServer.start_link(__MODULE__, [], opts)
	end

	def initialize(server, name, type, mark, game_type) do
		GenServer.call(server, {:initialize, name, type, mark, game_type})
	end

	def move(server, board) do
		GenServer.call(server, {:move, board})
	end

	def move(server, board, move) do
		GenServer.call(server, {:move, board, move})
	end

	def init([]) do
		state = %{}
		{:ok, state}
	end

	def handle_call({:initialize, name, type, mark, :computer_computer}, _from, _state) do
		state = %{name: name, type: type, mark: mark, strategy: :simple}

		{:reply, {:ok, state}, state}
	end

	def handle_call({:initialize, name, :computer, mark, :human_computer}, _from, _state) do
		state = %{name: name, type: :computer, mark: mark, strategy: :kickass}

		{:reply, {:ok, state}, state}
	end

	def handle_call({:initialize, name, :human, mark, _game_type}, _from, _state) do
		state = %{name: name, type: :human, mark: mark, strategy: :human}

		{:reply, {:ok, state}, state}
	end

	def handle_call({:move, board}, _from, state) do
		strategy = state[:strategy]
		mark = state[:mark]

		position = play(strategy, board, mark)
		board = put_mark(board, position, mark)

		{:reply, {:ok, board}, state}
	end

	def handle_call({:move, board, move}, _from, state) do
		mark = state[:mark]

		board = GameEngine.Board.put_mark(board, move, mark)

		{:reply, {:ok, board}, state}
	end

	def know_your_enemy(:o), do: :x
	def know_your_enemy(:x), do: :o

	defp play(:simple, board, _mark), do: GameEngine.PlayStrategies.SimpleStrategy.calculate_move(board)

	defp play(:kickass, board, mark), do: GameEngine.PlayStrategies.KickAssStrategy.calculate_move(board, mark)

	defp put_mark(board, :not_found, _mark), do: board

	defp put_mark(board, position, mark), do: GameEngine.Board.put_mark(board, position, mark)
 
end