defmodule GameEngine.PlayStrategies.Moves.OpponentsForksBlockerTest do
    use ExUnit.Case
    alias GameEngine.PlayStrategies.Moves.OpponentsForksBlocker, as: OpponentsForksBlocker

    @player :o
    @opponent :x

    test "takes out moves leading to opponents fork" do
        board = {@opponent, nil, nil,
                     nil, @player, nil,
                     nil, nil, @opponent}
        possible_move = %{row: 0, column: 2}
        list_of_moves = [possible_move]

        safe_moves = OpponentsForksBlocker.reject(list_of_moves, board, @player)

        assert safe_moves == []
    end

    test "refutes unsafe defense leading to opponent fork" do
        board = {@opponent, nil, nil,
                 nil, @player, nil,
                 nil, nil, @opponent}
        move = %{row: 0, column: 2}

        refute OpponentsForksBlocker.is_safe_defence?(move, board, @player)
    end

    test "refutes unsafe defense when opponent starts" do
        board = {@player, nil, nil,
                 nil, @opponent, nil,
                 nil, nil, @opponent}
        move = %{row: 0, column: 1}

        refute OpponentsForksBlocker.is_safe_defence?(move, board, @player)
    end

    test "finds safe defense" do
        board = {@player, nil, nil,
                 nil, @opponent, nil,
                 nil, nil, @opponent}
        move = %{row: 0, column: 2}

        assert OpponentsForksBlocker.is_safe_defence?(move, board, @player)
    end
end
