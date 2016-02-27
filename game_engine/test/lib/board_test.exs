defmodule GameEngine.BoardTest do
    use ExUnit.Case

    test "get empty board" do
      assert GameEngine.Board.get_empty == [nil, nil, nil,
                                            nil, nil, nil,
                                            nil, nil, nil]
    end

    test "returns o as winner if it has completed first row" do
        first_row_win = {:o, :o, :o,
                          nil, nil, nil,
                          nil, nil, nil}

        assert GameEngine.Board.resolve_winner(first_row_win) == :winner
    end

    test "returns x as winner if it has completed first row" do
        first_row_win = {:x, :x, :x,
                          nil, nil, nil,
                          nil, nil, nil}

        assert GameEngine.Board.resolve_winner(first_row_win) == :winner
    end

    test "returns player as winner if it has completed second row" do
        second_row_win = {:o, nil, nil,
                          :x, :x, :x,
                          nil, nil, nil}

        assert GameEngine.Board.resolve_winner(second_row_win) == :winner
    end

    test "returns player as winner if it has completed third row" do
        third_row_win = {:o, nil, nil,
                         :o, nil, nil,
                         :x, :x, :x}

        assert GameEngine.Board.resolve_winner(third_row_win) == :winner
    end

    test "returns player as winner if it has completed first column" do
        first_column_win = {:o, nil, nil,
                            :o, nil, nil,
                            :o, :x, :x}

        assert GameEngine.Board.resolve_winner(first_column_win) == :winner
    end

    test "returns player as winner if it has completed second column" do
        second_column_win = {nil, :o, nil,
                             nil, :o, nil,
                             nil, :o, :x}

        assert GameEngine.Board.resolve_winner(second_column_win) == :winner
    end

    test "returns player as winner if it has completed third column" do
        third_column_win = {nil, nil, :x,
                            nil, nil, :x,
                            nil, nil, :x}

        assert GameEngine.Board.resolve_winner(third_column_win) == :winner
    end

    test "returns player as winner if it has completed diagonal" do
        diagonal_win = {nil, nil, :o,
                        nil, :o, nil,
                        :o, nil, nil}

        assert GameEngine.Board.resolve_winner(diagonal_win) == :winner
    end

    test "returns player as winner if it has completed back diagonal" do
        back_diagonal_win = {:o, nil, nil,
                             nil, :o, nil,
                             nil, nil, :o}

        assert GameEngine.Board.resolve_winner(back_diagonal_win) == :winner
    end

    test "returns draw when all positions are occupied" do
        full_board = {:o, :o, :x,
                      :x, :x, :o,
                      :o, :x, :x}

        assert GameEngine.Board.resolve_winner(full_board) == :draw
    end

    test "no result when board has spare positions" do
        board_with_spare_positions = {:o, :o, :x,
                                      :x, nil, :o,
                                      :o, :x, :x}

        assert GameEngine.Board.resolve_winner(board_with_spare_positions) == :no_result
    end

    test "get a mark by given position" do
        positions = {:o, nil, nil,
                     nil, nil, nil,
                     nil, nil, nil}

        assert GameEngine.Board.get_by_position(positions, %{row: 0, column: 0}) == :o
    end

    test "put a mark in given position" do
        positions = {nil, nil, nil,
                     nil, nil, nil,
                     nil, nil, nil}
        position = %{row: 0, column: 0}
        board = GameEngine.Board.put_mark(positions, position, :o)

        assert GameEngine.Board.get_by_position(board, position) == :o
    end

    test "find two available positions in the board" do
        board_with_two_available_positions = {nil, nil, :o,
                                              :x, :o, :o,
                                              :x, :o, :x}

        available_positions = GameEngine.Board.available_positions(board_with_two_available_positions)

        assert available_positions == [%{row: 0, column: 0}, %{row: 0, column: 1}]
    end

    test "find four available positions in the board" do
        board_with_four_available_positions = {nil, nil, :o,
                                              :x, :o, nil,
                                              nil, :o, :x}

        available_positions = GameEngine.Board.available_positions(board_with_four_available_positions)

        assert available_positions == [%{row: 0, column: 0}, %{row: 0, column: 1}, %{row: 1, column: 2}, %{row: 2, column: 0}]
    end
end
