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
                  board: GameEngine.Board.get_empty,
                  o: o,
                  x: x,
                  next_player: next_player,
                  player: next_player}

        {:reply, {:ok, state}, state}
    end

    def handle_call({:move, _game_id}, _from, state) do
        {:ok, board_after_move} = GameEngine.Player.move(state[:next_player], state[:board])

        new_state = handle_move(state, board_after_move)

        {:reply, {:ok, new_state}, new_state}
    end

    def handle_call({:move, _game_id, move}, _from, state) do
        {:ok, board_after_move} = GameEngine.Player.move(state[:next_player], state[:board], move)

        new_state = handle_move(state, board_after_move)

        {:reply, {:ok, new_state}, new_state}
    end

    defp handle_move(state, board_after_move) do
        new_status = get_status(board_after_move)
        {player, next_player} = swap_players(state[:next_player])

        %{state | status: new_status, board: board_after_move, player: player, next_player: next_player}
    end

    def get_status(board_after_move) do
        cond do
            GameEngine.Board.resolve_winner(board_after_move) == :winner ->
                :winner

            GameEngine.Board.full?(board_after_move) ->
                :draw

            true ->
                :in_progress
        end
    end

    def swap_players(:o), do: {:o, :x}
    def swap_players(:x), do: {:x, :o}

    defp get_type_of_game(:computer, :computer),  do: :computer_computer
    defp get_type_of_game(:human, :computer),  do: :human_computer
    defp get_type_of_game(:computer, :human),  do: :human_computer
    defp get_type_of_game(:human, :human),  do: :human_human
end
