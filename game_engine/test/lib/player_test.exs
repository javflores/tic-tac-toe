defmodule GameEngine.PlayerTest do
    use ExUnit.Case

    import Mock

    @empty_board {nil, nil, nil, nil, nil, nil, nil, nil, nil}
    @player :o
    @opponent :x

    test "player plays received position in the board" do
        position = %{row: 0, column: 0}

        board = GameEngine.Player.move(@empty_board, position, @player)

        assert GameEngine.Board.get_by_position(board, position) == @player
    end

    test "player plays a perfect move by using minimax" do
        minimax_move = %{row: 1, column: 1}
        with_mock GameEngine.Minimax, [calculate_move: fn(_board, _player) -> minimax_move end] do

            board = GameEngine.Player.move(@empty_board, @player)

            assert GameEngine.Board.get_by_position(board, minimax_move) == @player
        end
    end

    test "player returns same board when no moves available" do
        full_board = {@opponent, @player, @player,
                      @player, @opponent, @opponent,
                      @player, @opponent, @player}

        assert GameEngine.Player.move(full_board, @player) == full_board
    end

    test "O is able to identify X as the opponent" do
        assert GameEngine.Player.know_your_enemy(@player) == @opponent
    end

    test "X is able to identify O as the opponent" do
        assert GameEngine.Player.know_your_enemy(@opponent) == @player
    end
end
