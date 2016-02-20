defmodule GameEngine.PlayStrategies.Moves.CenterTest do
    use ExUnit.Case
    alias GameEngine.PlayStrategies.Moves.Center, as: Center

    @player :o
    @opponent :x

    test "play center if available" do
        board = %GameEngine.Board{positions: {nil, nil, nil,
                                              nil, nil, nil,
                                              nil, nil, nil}}

        move = Center.find(board, @player)

        assert move == %{row: 1, column: 1}
    end

    test "cannot take center when taken" do
        board = %GameEngine.Board{positions: {nil, nil, nil,
                                              nil, @opponent, nil,
                                              nil, nil, nil}}

        move = Center.find(board, @player)

        assert move == nil
    end
end
