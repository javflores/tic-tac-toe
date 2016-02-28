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

        state = %{game_id: game_id,
                  status: :start,
                  type: type_of_game,
                  board: GameEngine.Board.get_empty,
                  o: o,
                  x: x,
                  next_player: next_player,
                  player: next_player}

        {:reply, {:ok, state}, state}
    end

    def handle_call({:move, _game_id}, _from, state) do
        new_board = GameEngine.Player.move(state[:board], state[:next_player])

        apply_move(new_board, state)
    end

    def handle_call({:move, _game_id, position}, _from, state) do
        new_board = GameEngine.Player.move(state[:board], position, state[:next_player])

        apply_move(new_board, state)
    end

    def apply_move(new_board, state) do
        game_status = get_status(new_board)
        {player, next_player} = swap_players(state[:next_player])

        state = %{state | status: game_status, board: new_board, player: player, next_player: next_player}

        {:reply, {:ok, state}, state}
    end

    def get_status(board) do
        GameEngine.Board.resolve_winner(board)
        |> status
    end

    defp status(:draw), do: :draw
    defp status(:winner), do: :winner
    defp status(:no_result), do: :in_progress

    def swap_players(:o), do: {:o, :x}
    def swap_players(:x), do: {:x, :o}

    defp get_type_of_game(:computer, :computer),  do: :computer_computer
    defp get_type_of_game(:human, :computer),  do: :human_computer
    defp get_type_of_game(:computer, :human),  do: :human_computer
    defp get_type_of_game(:human, :human),  do: :human_human
end
