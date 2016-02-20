defmodule GameEngine.BoardTest do
    use ExUnit.Case

    test "get empty board" do
      assert GameEngine.Board.get_empty == {nil, nil, nil,
                                            nil, nil, nil,
                                            nil, nil, nil}
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

    test "returns no winner" do
        no_win = {nil, nil, nil,
                  nil, nil, nil,
                  nil, nil, nil}

        assert GameEngine.Board.resolve_winner(no_win) == :no_winner
    end

    test "board is full" do
        full_board = {:o, :o, :x,
                      :x, :x, :o,
                      :o, :x, :x}

        assert GameEngine.Board.full?(full_board)
    end

    test "board has spare positions" do
        board_with_spare_positions = {:o, :o, :x,
                                      :x, nil, :o,
                                      :o, :x, :x}

        refute GameEngine.Board.full?(board_with_spare_positions)
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

    test "group rows" do
        positions = {nil, nil, nil,
                     :x, :x, :x,
                     :o, :o, :o}

        grouped_rows = GameEngine.Board.get_rows(positions)

        assert grouped_rows == [[nil, nil, nil], [:x, :x, :x], [:o, :o, :o]]
    end

    test "group columns" do
        positions = {nil, :x, :o,
                     nil, :x, :o,
                     nil, :x, :o}

        grouped_columns = GameEngine.Board.get_columns(positions)

        assert grouped_columns == [[nil, nil, nil], [:x, :x, :x], [:o, :o, :o]]
    end

    test "group diagonals" do
        positions = {nil, :x, :o,
                     nil, :x, :o,
                     nil, :x, :o}

        grouped_diagonals = GameEngine.Board.get_diagonals(positions)

        assert grouped_diagonals == [[nil, :x, :o], [:o, :x, nil]]
    end

    test "find triples containing all groups of rows" do
        positions = {:x, :x, :x,
                     nil, nil, nil,
                     :o, :o, :o}

        triples = GameEngine.Board.find_triples(positions)

        expected_rows = [[:x, :x, :x], [nil, nil, nil], [:o, :o, :o]]
        assert triples[:rows] == expected_rows
    end

    test "find triples containing all groups of columns" do
        positions = {:x, :x, :x,
                     nil, nil, nil,
                     :o, :o, :o}

        triples = GameEngine.Board.find_triples(positions)

        expected_columns = [[:x, nil, :o], [:x, nil, :o], [:x, nil, :o]]
        assert triples[:columns] == expected_columns
    end

    test "find triples containing all groups of diagonals" do
        positions = {:x, nil, :o,
                     nil, :x, nil,
                     :o, nil, :x}

        triples = GameEngine.Board.find_triples(positions)

        expected_diagonals = [[:x, :x, :x], [:o, :x, :o]]
        assert triples[:diagonals] == expected_diagonals
    end

    test "find if triple has two empty spaces where player has one mark in first position" do
        assert GameEngine.Board.two_empty_spaces?({[:o, nil, nil], 1}, :o)
    end

    test "find if triple has two empty spaces where player has one mark in middle position" do
        assert GameEngine.Board.two_empty_spaces?({[nil, :o, nil], 1}, :o)
    end

    test "find if triple has two empty spaces where player has one mark in last position" do
        assert GameEngine.Board.two_empty_spaces?({[nil, nil, :o], 1}, :o)
    end

    test "triple without empty spaces" do
        refute GameEngine.Board.two_empty_spaces?({[:o, nil, :x], 1}, :o)
    end

    test "get triples with two empty spaces and one mark by player" do
        row = [[:o, nil, nil], [nil, nil, :o], [:o, nil, :x]]
        triples_found = GameEngine.Board.two_empty_spaces(row, :o)

        assert triples_found == [{[:o, nil, nil], 0}, {[nil, nil, :o], 1}]
    end

    test "find triples with two empty spaces in whole board" do
        positions = {:x, :o, :x,
                     nil, nil, nil,
                     nil, nil, :o}

        two_empty_spaces_triples = GameEngine.Board.two_empty_spaces_triples_in_board(positions, :x)

        expected_triples = %{rows: [], columns: [{[:x, nil, nil], 0}], diagonals: [{[:x, nil, nil], 1}]}
        assert two_empty_spaces_triples == expected_triples
    end
end
