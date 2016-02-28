defmodule GameEngine.BoardTest do
    use ExUnit.Case

    test "get empty board" do
      assert GameEngine.Board.get_empty == [nil, nil, nil,
                                            nil, nil, nil,
                                            nil, nil, nil]
    end

    test "get rows in board" do
      board = [:o, :o, :o,
               nil, nil, nil,
               :x, :x, :x]

      assert GameEngine.Board.get_rows(board) == [[:o, :o, :o], [nil, nil, nil], [:x, :x, :x]]
    end

    test "get first column in board" do
      board = [:o, :o, :o,
               nil, nil, nil,
               :x, :x, :x]

      assert GameEngine.Board.get_column(0, board) == [:o, nil, :x]
    end

    test "get columns in board" do
      board = [:o, :o, :o,
               nil, nil, nil,
               :x, :x, :x]

      assert GameEngine.Board.get_columns(board) == [[:o, nil, :x], [:o, nil, :x], [:o, nil, :x]]
    end

    test "get first diagonal" do
      board = [:o, nil, nil,
               nil, :o, nil,
               nil, nil, :o]

      assert GameEngine.Board.first_diagonal(board) == [:o, :o, :o]
    end

    test "get second diagonal" do
      board = [nil, nil, :x,
               nil, :x, nil,
               :x, nil, nil]

      assert GameEngine.Board.second_diagonal(board) == [:x, :x, :x]
    end

    test "get diagonals" do
      board = [nil, nil, :x,
               nil, :x, nil,
               :x, nil, nil]

      assert GameEngine.Board.get_diagonals(board) == [[nil, :x, nil], [:x, :x, :x]]
    end

    test "get groups" do
      board = [nil, nil, :x,
               nil, :x, nil,
               :x, nil, nil]

      assert GameEngine.Board.get_groups(board) == [[nil, nil, :x], [nil, :x, nil], [:x, nil, nil],
                                                    [nil, nil, :x], [nil, :x, nil], [:x, nil, nil],
                                                    [nil, :x, nil], [:x, :x, :x]]
    end

    test "winner when O has completed first diagonal" do
        first_diagonal_win = [:o, :x, :x,
                              nil, :o, nil,
                              nil, nil, :o]

        assert GameEngine.Board.winner(first_diagonal_win) == :winner
    end

    test "returns winner when O has completed first diagonal" do
        first_diagonal = [:o, :x, :x,
                          nil, :o, nil,
                          nil, nil, :o]

        assert GameEngine.Board.resolve_winner(first_diagonal) == :winner
    end

    test "returns draw when all positions are occupied" do
        full_board = [:o, :o, :x,
                      :x, :x, :o,
                      :o, :x, :x]

        assert GameEngine.Board.resolve_winner(full_board) == :draw
    end

    test "no result when board has spare positions" do
        board_with_spare_positions = [:o, :o, :x,
                                      :x, nil, :o,
                                      :o, :x, :x]

        assert GameEngine.Board.resolve_winner(board_with_spare_positions) == :no_result
    end

    test "get a mark by given position" do
        positions = [:o, nil, nil,
                     nil, nil, nil,
                     nil, nil, nil]

        assert GameEngine.Board.get_by_position(positions, %{row: 0, column: 0}) == :o
    end

    test "put a mark in given position" do
        board = [nil, nil, nil,
                     nil, nil, nil,
                     nil, nil, nil]
        position = %{row: 0, column: 0}
        board = GameEngine.Board.put_mark(board, position, :o)

        assert GameEngine.Board.get_by_position(board, position) == :o
    end

    test "find two available positions in the board" do
        board_with_two_available_positions = [nil, nil, :o,
                                              :x, :o, :o,
                                              :x, :o, :x]

        available_positions = GameEngine.Board.available_positions(board_with_two_available_positions)

        assert available_positions == [%{row: 0, column: 0}, %{row: 0, column: 1}]
    end

    test "find four available positions in the board" do
        board_with_four_available_positions = [nil, nil, :o,
                                              :x, :o, nil,
                                              nil, :o, :x]

        available_positions = GameEngine.Board.available_positions(board_with_four_available_positions)

        assert available_positions == [%{row: 0, column: 0}, %{row: 0, column: 1}, %{row: 1, column: 2}, %{row: 2, column: 0}]
    end
end
