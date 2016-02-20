defmodule GameEngine.BoardCutterTest do
    use ExUnit.Case
    alias GameEngine.BoardCutter, as: BoardCutter

    @player :o

    test "find coordinates of all triples with two empty spaces and one position played by player" do
        triples = %{rows: [{[nil, nil, @player], 0}],
                    columns: [{[nil, nil, @player], 1}],
                    diagonals: [{[nil, nil, @player], 0}]}

        %{all: empty_spaces, non_duplicates: _non_duplicated} = BoardCutter.triples_with_two_empty_spaces(triples)

        assert empty_spaces == [%{column: 0, row: 0}, %{column: 1, row: 0}, %{column: 1, row: 0},
                                %{column: 1, row: 1}, %{column: 0, row: 0}, %{column: 1, row: 1}]
    end

    test "find non-duplicated triples with two empty spaces and one position played by player" do
        triples = %{rows: [{[nil, nil, @player], 0}, {[nil, nil, @player], 1}],
                    columns: [{[nil, nil, @player], 0}], diagonals: []}

        %{non_duplicates: non_duplicated, all: _empty_spaces} = BoardCutter.triples_with_two_empty_spaces(triples)

        assert non_duplicated == [%{column: 0, row: 0}, %{column: 1, row: 0}, %{column: 0, row: 1}, %{column: 1, row: 1}]
    end

    test "find coordinates of empty spaces in a row with last position taken by player" do
        empty_spaces = BoardCutter.two_empty_spaces_in_rows({[nil, nil, @player], 1})

        assert empty_spaces == [%{row: 1, column: 0}, %{row: 1, column: 1}]
    end

    test "find coordinates of empty spaces in a row with middle position taken by player" do
        empty_spaces = BoardCutter.two_empty_spaces_in_rows({[nil, @player, nil], 1})

        assert empty_spaces == [%{row: 1, column: 0}, %{row: 1, column: 2}]
    end

    test "find coordinates of empty spaces in a row with first position taken by player" do
        empty_spaces = BoardCutter.two_empty_spaces_in_rows({[@player, nil, nil], 1})

        assert empty_spaces == [%{row: 1, column: 1}, %{row: 1, column: 2}]
    end

    test "find coordinates of empty spaces in several rows" do
        empty_spaces = BoardCutter.two_empty_spaces_in_rows([{[@player, nil, nil], 1}, {[nil, nil, @player], 2}])

        assert empty_spaces == [%{row: 1, column: 1}, %{row: 1, column: 2}, %{row: 2, column: 0}, %{row: 2, column: 1}]
    end

    test "find coordinates of empty spaces in a column with last position taken by player" do
        empty_spaces = BoardCutter.two_empty_spaces_in_columns({[nil, nil, @player], 0})

        assert empty_spaces == [%{row: 0, column: 0}, %{row: 1, column: 0}]
    end

    test "find coordinates of empty spaces in a column with middle position taken by player" do
        empty_spaces = BoardCutter.two_empty_spaces_in_columns({[nil, @player, nil], 0})

        assert empty_spaces == [%{row: 0, column: 0}, %{row: 2, column: 0}]
    end

    test "find coordinates of empty spaces in a column with first position taken by player" do
        empty_spaces = BoardCutter.two_empty_spaces_in_columns({[@player, nil, nil], 0})

        assert empty_spaces == [%{row: 1, column: 0}, %{row: 2, column: 0}]
    end

    test "find coordinates of empty spaces in several columns" do
        empty_spaces = BoardCutter.two_empty_spaces_in_columns([{[@player, nil, nil], 1}, {[nil, nil, @player], 2}])

        assert empty_spaces == [%{row: 1, column: 1}, %{row: 2, column: 1}, %{row: 0, column: 2}, %{row: 1, column: 2}]
    end

    test "find coordinates of empty spaces in diagonal with last position taken by player" do
        empty_spaces = BoardCutter.two_empty_spaces_in_diagonals({[nil, nil, @player], 0})

        assert empty_spaces == [%{row: 0, column: 0}, %{row: 1, column: 1}]
    end

    test "find coordinates of empty spaces in back diagonal with last position taken by player" do
        empty_spaces = BoardCutter.two_empty_spaces_in_diagonals({[nil, nil, @player], 1})

        assert empty_spaces == [%{row: 0, column: 2}, %{row: 1, column: 1}]
    end

    test "find coordinates of empty spaces in diagonal with middle position taken by player" do
        empty_spaces = BoardCutter.two_empty_spaces_in_diagonals({[nil, @player, nil], 0})

        assert empty_spaces == [%{row: 0, column: 0}, %{row: 2, column: 2}]
    end

    test "find coordinates of empty spaces in back diagonal with middle position taken by player" do
        empty_spaces = BoardCutter.two_empty_spaces_in_diagonals({[nil, @player, nil], 1})

        assert empty_spaces == [%{row: 0, column: 2}, %{row: 2, column: 0}]
    end

    test "find coordinates of empty spaces in diagonal with first position taken by player" do
        empty_spaces = BoardCutter.two_empty_spaces_in_diagonals({[@player, nil, nil], 0})

        assert empty_spaces == [%{row: 1, column: 1}, %{row: 2, column: 2}]
    end

    test "find coordinates of empty spaces in back diagonal with first position taken by player" do
        empty_spaces = BoardCutter.two_empty_spaces_in_diagonals({[@player, nil, nil], 1})

        assert empty_spaces == [%{row: 1, column: 1}, %{row: 2, column: 0}]
    end

    test "find coordinates of empty spaces in several diagonals" do
        empty_spaces = BoardCutter.two_empty_spaces_in_diagonals([{[nil, @player, nil], 0}, {[@player, nil, nil], 1}])

        assert empty_spaces == [%{row: 0, column: 0}, %{row: 2, column: 2}, %{row: 1, column: 1}, %{row: 2, column: 0}]
    end
end
