defmodule GameEngine.KickAssStrategyForkMovesTest do
	use ExUnit.Case
	alias GameEngine.PlayStrategies.KickAssForkMoves, as: KickAssForkMoves

	test "find if triple has two empty spaces where player has one mark in first position" do
		assert KickAssForkMoves.two_empty_spaces?({[:o, nil, nil], 1}, :o) == true
	end

	test "find if triple has two empty spaces where player has one mark in middle position" do
		assert KickAssForkMoves.two_empty_spaces?({[nil, :o, nil], 1}, :o) == true
	end

	test "find if triple has two empty spaces where player has one mark in last position" do
		assert KickAssForkMoves.two_empty_spaces?({[nil, nil, :o], 1}, :o) == true
	end

	test "triple without empty spaces" do
		assert KickAssForkMoves.two_empty_spaces?({[:o, nil, :x], 1}, :o) == false
	end

	test "get triples with two empty spaces and one mark by player" do
		row = [[:o, nil, nil], [nil, nil, :o], [:o, nil, :x]]
		triples_found = KickAssForkMoves.two_empty_spaces(row, :o)

		assert triples_found == [{[:o, nil, nil], 0}, {[nil, nil, :o], 1}]
	end

	test "find triples with two empty spaces in whole board as preparation to find a fork" do
		positions = {:x, :o, :x,
					 nil, nil, nil,
					 nil, nil, :o}

		two_empty_spaces_triples = KickAssForkMoves.two_empty_spaces_triples_in_board(%GameEngine.Board{positions: positions}, :x)

		expected_triples = %{rows: [], columns: [{[:x, nil, nil], 0}], diagonals: [{[:x, nil, nil], 1}]}			
		assert two_empty_spaces_triples == expected_triples
	end

	test "find coordinates of empty spaces in a row with last position taken by player" do
		empty_spaces = KickAssForkMoves.empty_spaces_in_rows({[nil, nil, :o], 1})

		assert empty_spaces == [%{row: 1, column: 0}, %{row: 1, column: 1}]
	end

	test "find coordinates of empty spaces in a row with middle position taken by player" do
		empty_spaces = KickAssForkMoves.empty_spaces_in_rows({[nil, :o, nil], 1})

		assert empty_spaces == [%{row: 1, column: 0}, %{row: 1, column: 2}]
	end

	test "find coordinates of empty spaces in a row with first position taken by player" do
		empty_spaces = KickAssForkMoves.empty_spaces_in_rows({[:o, nil, nil], 1})

		assert empty_spaces == [%{row: 1, column: 1}, %{row: 1, column: 2}]
	end

	test "find coordinates of empty spaces in several rows" do
		empty_spaces = KickAssForkMoves.empty_spaces_in_rows([{[:o, nil, nil], 1}, {[nil, nil, :o], 2}])

		assert empty_spaces == [%{row: 1, column: 1}, %{row: 1, column: 2}, %{row: 2, column: 0}, %{row: 2, column: 1}]
	end

	test "find coordinates of empty spaces in a column with last position taken by player" do
		empty_spaces = KickAssForkMoves.empty_spaces_in_columns({[nil, nil, :o], 0})

		assert empty_spaces == [%{row: 0, column: 0}, %{row: 1, column: 0}]
	end

	test "find coordinates of empty spaces in a column with middle position taken by player" do
		empty_spaces = KickAssForkMoves.empty_spaces_in_columns({[nil, :o, nil], 0})

		assert empty_spaces == [%{row: 0, column: 0}, %{row: 2, column: 0}]
	end

	test "find coordinates of empty spaces in a column with first position taken by player" do
		empty_spaces = KickAssForkMoves.empty_spaces_in_columns({[:o, nil, nil], 0})

		assert empty_spaces == [%{row: 1, column: 0}, %{row: 2, column: 0}]
	end

	test "find coordinates of empty spaces in several columns" do
		empty_spaces = KickAssForkMoves.empty_spaces_in_columns([{[:o, nil, nil], 1}, {[nil, nil, :o], 2}])

		assert empty_spaces == [%{row: 1, column: 1}, %{row: 2, column: 1}, %{row: 0, column: 2}, %{row: 1, column: 2}]
	end

	test "find coordinates of empty spaces in diagonal with last position taken by player" do
		empty_spaces = KickAssForkMoves.empty_spaces_in_diagonals({[nil, nil, :o], 0})

		assert empty_spaces == [%{row: 0, column: 0}, %{row: 1, column: 1}]
	end

	test "find coordinates of empty spaces in back diagonal with last position taken by player" do
		empty_spaces = KickAssForkMoves.empty_spaces_in_diagonals({[nil, nil, :o], 1})

		assert empty_spaces == [%{row: 0, column: 2}, %{row: 1, column: 1}]
	end

	test "find coordinates of empty spaces in diagonal with middle position taken by player" do
		empty_spaces = KickAssForkMoves.empty_spaces_in_diagonals({[nil, :o, nil], 0})

		assert empty_spaces == [%{row: 0, column: 0}, %{row: 2, column: 2}]
	end

	test "find coordinates of empty spaces in back diagonal with middle position taken by player" do
		empty_spaces = KickAssForkMoves.empty_spaces_in_diagonals({[nil, :o, nil], 1})

		assert empty_spaces == [%{row: 0, column: 2}, %{row: 2, column: 0}]
	end

	test "find coordinates of empty spaces in diagonal with first position taken by player" do
		empty_spaces = KickAssForkMoves.empty_spaces_in_diagonals({[:o, nil, nil], 0})

		assert empty_spaces == [%{row: 1, column: 1}, %{row: 2, column: 2}]
	end

	test "find coordinates of empty spaces in back diagonal with first position taken by player" do
		empty_spaces = KickAssForkMoves.empty_spaces_in_diagonals({[:o, nil, nil], 1})

		assert empty_spaces == [%{row: 1, column: 1}, %{row: 2, column: 0}]
	end

	test "find coordinates of empty spaces in several diagonals" do
		empty_spaces = KickAssForkMoves.empty_spaces_in_diagonals([{[nil, :o, nil], 0}, {[:o, nil, nil], 1}])

		assert empty_spaces == [%{row: 0, column: 0}, %{row: 2, column: 2}, %{row: 1, column: 1}, %{row: 2, column: 0}]
	end

	test "find fork as an empty space included in two triples with two empty spaces" do
		positions_with_fork_in_bottom_left_corner = {:x, :o, nil,
													 nil, :x, nil,
													 nil, nil, :o}

		fork = KickAssForkMoves.fork(%GameEngine.Board{positions: positions_with_fork_in_bottom_left_corner}, :x)

		expected_fork = %{row: 1, column: 0}		
		assert fork == expected_fork
	end
end