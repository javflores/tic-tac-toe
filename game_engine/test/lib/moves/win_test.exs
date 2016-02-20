defmodule GameEngine.PlayStrategies.Moves.WinTest do
    use ExUnit.Case

    alias GameEngine.PlayStrategies.Moves.Win, as: Win

    @player :o
    @opponent :x

    test "winning horizontally horizontally taking first row and last column" do
        first_row_win = {@player, @player, nil,
                         nil, nil, nil,
                         @opponent, @opponent, nil}

        move = Win.find(%GameEngine.Board{positions: first_row_win}, @player)

        assert move == %{row: 0, column: 2}
    end

    test "winning horizontally taking first row and middle column" do
        first_row_win = {@player, nil, @player,
                         nil, nil, nil,
                         @opponent, @opponent, nil}

        move = Win.find(%GameEngine.Board{positions: first_row_win}, @player)

        assert move == %{row: 0, column: 1}
    end

    test "winning horizontally taking first row and first column" do
        first_row_win = {nil, @player, @player,
                         nil, @opponent, nil,
                         @opponent, nil, nil}

        move = Win.find(%GameEngine.Board{positions: first_row_win}, @player)

        assert move == %{row: 0, column: 0}
    end

    test "winning horizontally taking second row and last column" do
        second_row_win = {nil, nil, @opponent,
                         @player, @player, nil,
                         nil, @opponent, nil}

        move = Win.find(%GameEngine.Board{positions: second_row_win}, @player)

        assert move == %{row: 1, column: 2}
    end

    test "winning horizontally taking second row and middle column" do
        second_row_win = {nil, nil, nil,
                         @player, nil, @player,
                         nil, @opponent, @opponent}

        move = Win.find(%GameEngine.Board{positions: second_row_win}, @player)

        assert move == %{row: 1, column: 1}
    end

    test "winning horizontally taking second row and first column" do
        second_row_win = {@opponent, @opponent, nil,
                          nil, @player, @player,
                         nil, @opponent, nil}

        move = Win.find(%GameEngine.Board{positions: second_row_win}, @player)

        assert move == %{row: 1, column: 0}
    end

    test "winning horizontally taking third row and last column" do
        third_row_win = {nil, nil, @opponent,
                         nil, @opponent, nil,
                         @player, @player, nil}

        move = Win.find(%GameEngine.Board{positions: third_row_win}, @player)

        assert move == %{row: 2, column: 2}
    end

    test "winning horizontally taking third row and middle column" do
        third_row_win = {nil, @opponent, nil,
                         nil, @opponent, @opponent,
                         @player, nil, @player}

        move = Win.find(%GameEngine.Board{positions: third_row_win}, @player)

        assert move == %{row: 2, column: 1}
    end

    test "winning horizontally taking third row and first column" do
        third_row_win = {nil, nil, nil,
                         nil, nil, nil,
                         nil, @player, @player}

        move = Win.find(%GameEngine.Board{positions: third_row_win}, @player)

        assert move == %{row: 2, column: 0}
    end


    test "winning vertically horizontally taking first row and first column" do
        first_column_win = {nil, @opponent, nil,
                            @player, nil, nil,
                            @player, nil, nil}

        move = Win.find(%GameEngine.Board{positions: first_column_win}, @player)

        assert move == %{row: 0, column: 0}
    end

    test "winning vertically taking middle row and first column" do
        first_column_win = {@player, nil, nil,
                            nil, nil, nil,
                            @player, nil, nil}

        move = Win.find(%GameEngine.Board{positions: first_column_win}, @player)

        assert move == %{row: 1, column: 0}
    end

    test "winning vertically taking last row and first column" do
        first_column_win = {@player, @opponent, @player,
                            @player, nil, nil,
                            nil, nil, nil}

        move = Win.find(%GameEngine.Board{positions: first_column_win}, @player)

        assert move == %{row: 2, column: 0}
    end

    test "winning vertically taking first row and second column" do
        second_column_win = {nil, nil, nil,
                             nil, @player, nil,
                             nil, @player, nil}

        move = Win.find(%GameEngine.Board{positions: second_column_win}, @player)

        assert move == %{row: 0, column: 1}
    end

    test "winning vertically taking middle row and second column" do
        second_column_win = {nil, @player, nil,
                             nil, nil, @player,
                             nil, @player, nil}

        move = Win.find(%GameEngine.Board{positions: second_column_win}, @player)

        assert move == %{row: 1, column: 1}
    end

    test "winning vertically taking last row and second column" do
        second_column_win = {nil, @player, nil,
                             nil, @player, nil,
                             nil, nil, nil}

        move = Win.find(%GameEngine.Board{positions: second_column_win}, @player)

        assert move == %{row: 2, column: 1}
    end

    test "winning vertically taking first row and last column" do
        third_column_win = {nil, nil, nil,
                            nil, nil, @player,
                            nil, nil, @player}

        move = Win.find(%GameEngine.Board{positions: third_column_win}, @player)

        assert move == %{row: 0, column: 2}
    end

    test "winning vertically taking middle row and last column" do
        third_column_win = {nil, nil, @player,
                            nil, nil, nil,
                            nil, nil, @player}

        move = Win.find(%GameEngine.Board{positions: third_column_win}, @player)

        assert move == %{row: 1, column: 2}
    end

    test "winning vertically taking last row and last column" do
        third_column_win = {nil, nil, @player,
                            nil, nil, @player,
                            nil, nil, nil}

        move = Win.find(%GameEngine.Board{positions: third_column_win}, @player)

        assert move == %{row: 2, column: 2}
    end

    test "winning diagonally taking top left corner" do
        diagonal_win = {nil, nil, @opponent,
                        nil, @player, nil,
                        @opponent, nil, @player}

        move = Win.find(%GameEngine.Board{positions: diagonal_win}, @player)

        assert move == %{row: 0, column: 0}
    end

    test "winning diagonally taking center" do
        diagonal_win = {@player, nil, @opponent,
                        nil, nil, nil,
                        @opponent, nil, @player}

        move = Win.find(%GameEngine.Board{positions: diagonal_win}, @player)

        assert move == %{row: 1, column: 1}
    end

    test "winning diagonally taking bottom right corner" do
        diagonal_win = {@player, nil, @opponent,
                        nil, @player, nil,
                        @opponent, nil, nil}

        move = Win.find(%GameEngine.Board{positions: diagonal_win}, @player)

        assert move == %{row: 2, column: 2}
    end

    test "winning diagonally taking top right corner" do
        diagonal_win = {nil, nil, nil,
                        nil, @player, nil,
                        @player, nil, nil}

        move = Win.find(%GameEngine.Board{positions: diagonal_win}, @player)

        assert move == %{row: 0, column: 2}
    end

    test "winning diagonally taking center with back diagonal" do
        diagonal_win = {nil, nil, @player,
                        nil, nil, nil,
                        @player, nil, nil}

        move = Win.find(%GameEngine.Board{positions: diagonal_win}, @player)

        assert move == %{row: 1, column: 1}
    end

    test "winning diagonally taking bottom left corner" do
        diagonal_win = {nil, nil, @player,
                        nil, @player, nil,
                        nil, nil, nil}

        move = Win.find(%GameEngine.Board{positions: diagonal_win}, @player)

        assert move == %{row: 2, column: 0}
    end
end
