defmodule GameEngine.MinimaxTest do

    use ExUnit.Case

    @player :o
    @tagged_player {@player, false}
    @opponent :x
    @tagged_opponent {@opponent, true}
    @fake_position %{}

    test "calculates move based on minimax" do
        board = [@opponent, nil, nil,
                nil, @player, nil,
                nil, nil, @opponent]

        block_opponent_fork = %{row: 0, column: 1}
        assert GameEngine.Minimax.calculate_move(board, @player) == block_opponent_fork
    end

    test "finds win score and fake position when player wins" do
        assert GameEngine.Minimax.inspect_result(:winner, @tagged_player, []) == {@fake_position, -1}
    end

    test "finds loose score and fake position when opponent wins" do
        assert GameEngine.Minimax.inspect_result(:winner, @tagged_opponent, []) == {@fake_position, 1}
    end

    test "finds draw score and fake position if no winner" do
        assert GameEngine.Minimax.inspect_result(:draw, @tagged_opponent, []) == {@fake_position, 0}
    end

    test "defines initial best position for player out of range to ensure better score is found" do
        is_opponent = false
        assert GameEngine.Minimax.initial_best(is_opponent) == {@fake_position, -2}
    end

    test "defines initial best score for opponent out of range to ensure better score is found" do
        is_opponent = true
        assert GameEngine.Minimax.initial_best(is_opponent) == {@fake_position, 2}
    end

    test "finds maximum score for position when is players turn" do
        best = {%{row: 1, column: 1}, 1}
        current_best = {%{row: 0, column: 0}, -2}
        is_opponent = false
        assert GameEngine.Minimax.min_or_max(is_opponent, best, current_best) == best
    end

    test "finds current best when intermediate score is not maximum for player" do
        intermediate = {%{row: 1, column: 1}, 0}
        current_best = {%{row: 0, column: 0}, 1}
        is_opponent = false
        assert GameEngine.Minimax.min_or_max(is_opponent, intermediate, current_best) == current_best
    end

    test "finds minimum score for position when is opponent turn" do
        best = {%{row: 1, column: 1}, -1}
        current_best = {%{row: 0, column: 0}, 2}
        is_opponent = true
        assert GameEngine.Minimax.min_or_max(is_opponent, best, current_best) == best
    end

    test "finds current best when not minimum for opponent" do
        intermediate = {%{row: 1, column: 1}, 0}
        current_best = {%{row: 0, column: 0}, -1}
        is_opponent = true
        assert GameEngine.Minimax.min_or_max(is_opponent, intermediate, current_best) == current_best
    end

    test "finds win position for player when game is over" do
        board = [@player, @player, @player,
                 @opponent, @opponent, nil,
                 @opponent, @opponent, nil]

        assert GameEngine.Minimax.minimax(board, @tagged_player) == {@fake_position, -1}
    end

    test "finds loose position for player when game is over" do
        board = [@player, @player, @opponent,
                 @opponent, @opponent, nil,
                 @opponent, @opponent, nil]

        assert GameEngine.Minimax.minimax(board, @tagged_opponent) == {@fake_position, 1}
    end

    test "finds win position for player in next step" do
        board = [@player, @player, nil,
                 @opponent, @opponent, @player,
                 @opponent, @opponent, @player]
        win_position = %{row: 0, column: 2}

        assert GameEngine.Minimax.minimax(board, @tagged_player) == {win_position, 1}
    end

    test "finds loosing position in next step" do
        board = [@player, @player, nil,
                 @opponent, @opponent, nil,
                 @opponent, @opponent, nil]

        loosing_position = %{row: 0, column: 2}
        assert GameEngine.Minimax.minimax(board, @tagged_opponent) == {loosing_position, -1}
    end

    test "blocks opponent from winning in next step" do
        board = [@player, @player, @opponent,
                nil, @opponent, @player,
                nil, nil, @opponent]

        block_opponent = %{row: 2, column: 0}
        assert GameEngine.Minimax.minimax(board, @tagged_player) == {block_opponent, 0}
    end

    test "finds fork position leading to win in two steps for player" do
        board = [@player, @opponent, nil,
                nil, @player, nil,
                nil, nil, @opponent]

        fork = %{row: 1, column: 0}
        assert GameEngine.Minimax.minimax(board, @tagged_player) == {fork, 1}
    end

    test "blocks fork for opponent by attacking" do
        board = [@opponent, nil, nil,
                nil, @player, nil,
                nil, nil, @opponent]

        block_opponent_fork = %{row: 0, column: 1}
        assert GameEngine.Minimax.minimax(board, @tagged_player) == {block_opponent_fork, 0}
    end

    test "swaps player" do
        assert GameEngine.Minimax.swap_player(@tagged_player) == @tagged_opponent
    end

end
