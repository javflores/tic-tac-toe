defmodule GameEngine.PlayStrategies.Moves.EmptySideTest do
    use ExUnit.Case
    alias GameEngine.PlayStrategies.Moves.EmptySide, as: EmptySide

    @player :o
    @opponent :x

    test "take empty top side" do
        board = {@opponent, nil, @player,
                 nil, @opponent, nil,
                 @player, nil, @player}

        move = EmptySide.find(board, @player)

        assert move == %{row: 0, column: 1}
    end

    test "take empty left side" do
        board = {@player, @player, @opponent,
                 nil, @opponent, nil,
                 @opponent, nil, @opponent}

        move = EmptySide.find(board, @player)

        assert move == %{row: 1, column: 0}
    end

    test "take empty right side" do
        board = {@player, @player, @opponent,
                 @player, @opponent, nil,
                 @player, nil, @player}

        move = EmptySide.find(board, @player)

        assert move == %{row: 1, column: 2}
    end

    test "take empty bottom side" do
        board = {@player, @player, @opponent,
                 @player, @opponent, @opponent,
                 @player, nil, @player}

        move = EmptySide.find(board, @player)

        assert move == %{row: 2, column: 1}
    end

    test "no sides available" do
        board = {@opponent, @player, @player,
                 @player, @opponent, @opponent,
                 @player, @opponent, @player}

        move = EmptySide.find(board, @player)

        assert move == nil
    end
end
