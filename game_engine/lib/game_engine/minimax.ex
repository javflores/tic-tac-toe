defmodule GameEngine.Minimax do

    @fake_position %{}
    @win_score 1
    @loose_score -1
    @win {@fake_position, -@win_score}
    @loose {@fake_position, -@loose_score}
    @draw {@fake_position, 0}
    @initial_best_for_player {@fake_position, -2}
    @initial_best_for_opponent {@fake_position, 2}

    def calculate_move(board, player) do
        {position, score} = minimax(board, {player, false})
        position
    end

    def minimax(board, tagged_player) do
        GameEngine.Board.resolve_winner(board)
        |> inspect_result(tagged_player, board)
    end

    def inspect_result(:winner, {_player, true}, _board), do: @loose

    def inspect_result(:winner, {_player, false}, _board), do: @win

    def inspect_result(:draw, _player, _board), do: @draw

    def inspect_result(:no_result, tagged_player, board) do
        {player, is_opponent} = tagged_player

        GameEngine.Board.available_positions(board)
        |> Enum.reduce_while(initial_best(is_opponent), fn(position, best) ->
            {_previous, score} = GameEngine.Board.put_mark(board, position, player)
            |> minimax(swap_player(tagged_player))

            best = min_or_max(is_opponent, {position, score}, best)
            pruning(is_opponent, best)
        end)
    end

    def initial_best(false), do: @initial_best_for_player
    def initial_best(true), do: @initial_best_for_opponent

    def min_or_max(is_opponent, current, best) do
        {_best_position, best_score} = best
        {_current_position, current_score} = current
        cond do
            !is_opponent and current_score > best_score ->
                current
            is_opponent and current_score < best_score ->
                current
            true ->
                best
        end
    end

    def pruning(false, {best_position, best_score}) when best_score == @win_score, do: {:halt, {best_position, best_score}}
    def pruning(true, {best_position, best_score}) when best_score == @loose_score, do: {:halt, {best_position, best_score}}
    def pruning(_is_opponent, best), do: {:cont, best}

    def swap_player({player, is_opponent}), do: {GameEngine.Player.know_your_enemy(player), !is_opponent}
end
