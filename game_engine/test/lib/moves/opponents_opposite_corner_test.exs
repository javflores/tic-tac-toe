defmodule GameEngine.PlayStrategies.Moves.OpponentsOppositeCornerTest do

    use ExUnit.Case
    alias GameEngine.PlayStrategies.Moves.OpponentsOppositeCorner, as: OpponentsOppositeCorner

    @player :o
    @opponent :x

    test "play bottom right corner opposite to opponents corner" do
        board = {@opponent, nil, nil,
                 nil, @player, nil,
                 nil, nil, nil}

        opposite_corner = OpponentsOppositeCorner.find(board, @player)

        assert opposite_corner == %{row: 2, column: 2}
    end

    test "play bottom left corner opposite to opponents corner" do
        board = {nil, nil, @opponent,
                 nil, @player, nil,
                 nil, nil, nil}

        opposite_corner = OpponentsOppositeCorner.find(board, @player)

        assert opposite_corner == %{row: 2, column: 0}
    end

    test "play top right corner opposite to opponents corner" do
        board = {nil, nil, nil,
                 nil, @player, nil,
                 @opponent, nil, nil}

        opposite_corner = OpponentsOppositeCorner.find(board, @player)

        assert opposite_corner == %{row: 0, column: 2}
    end

    test "play top left corner opposite to opponents corner" do
        board = {nil, nil, nil,
                 nil, @player, nil,
                 nil, nil, @opponent}

        opposite_corner = OpponentsOppositeCorner.find(board, @player)

        assert opposite_corner == %{row: 0, column: 0}
    end

    test "no corner available" do
        board = {@player, nil, @player,
                 nil, @player, nil,
                 @opponent, nil, @opponent}

        move = OpponentsOppositeCorner.find(board, @player)

        assert move == nil
    end
end
