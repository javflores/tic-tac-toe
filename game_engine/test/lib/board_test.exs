defmodule GameEngine.BoardTest do
	use ExUnit.Case

	test "can get board with empty positions" do
		empty_positions = {nil, nil, nil,
						  nil, nil, nil,
						  nil, nil, nil}

		empty_board = %GameEngine.Board{} 

		assert empty_board.positions == empty_positions
	end

	test "returns o as winner if it has completed first row" do
		first_row_win = {:o, :o, :o,
						  nil, nil, nil,
						  nil, nil, nil}

		{:winner, winner} = GameEngine.Board.resolve_winner(%GameEngine.Board{positions: first_row_win})

		assert winner == :o
	end

	test "returns x as winner if it has completed first row" do
		first_row_win = {:x, :x, :x,
						  nil, nil, nil,
						  nil, nil, nil}

		{:winner, winner} = GameEngine.Board.resolve_winner(%GameEngine.Board{positions: first_row_win})

		assert winner == :x
	end

	test "returns player as winner if it has completed second row" do
		second_row_win = {:o, nil, nil,
						  :x, :x, :x,
						  nil, nil, nil}

		{:winner, winner} = GameEngine.Board.resolve_winner(%GameEngine.Board{positions: second_row_win})

		assert winner == :x
	end

	test "returns player as winner if it has completed third row" do
		third_row_win = {:o, nil, nil,
						 :o, nil, nil,
						 :x, :x, :x}

		{:winner, winner} = GameEngine.Board.resolve_winner(%GameEngine.Board{positions: third_row_win})

		assert winner == :x
	end

	test "returns player as winner if it has completed first column" do
		first_column_win = {:o, nil, nil,
						 	:o, nil, nil,
						    :o, :x, :x}

		{:winner, winner} = GameEngine.Board.resolve_winner(%GameEngine.Board{positions: first_column_win})

		assert winner == :o
	end

	test "returns player as winner if it has completed second column" do
		second_column_win = {nil, :o, nil,
						 	 nil, :o, nil,
						     nil, :o, :x}

		{:winner, winner} = GameEngine.Board.resolve_winner(%GameEngine.Board{positions: second_column_win})

		assert winner == :o
	end

	test "returns player as winner if it has completed third column" do
		third_column_win = {nil, nil, :x,
						 	nil, nil, :x,
						    nil, nil, :x}

		{:winner, winner} = GameEngine.Board.resolve_winner(%GameEngine.Board{positions: third_column_win})

		assert winner == :x
	end

	test "returns player as winner if it has completed diagonal" do
		diagonal_win = {nil, nil, :o,
						nil, :o, nil,
						:o, nil, nil}

		{:winner, winner} = GameEngine.Board.resolve_winner(%GameEngine.Board{positions: diagonal_win})

		assert winner == :o
	end

	test "returns player as winner if it has completed back diagonal" do
		back_diagonal_win = {:o, nil, nil,
						     nil, :o, nil,
						     nil, nil, :o}

		{:winner, winner} = GameEngine.Board.resolve_winner(%GameEngine.Board{positions: back_diagonal_win})

		assert winner == :o
	end

	test "returns no winner" do
		back_diagonal_win = {nil, nil, nil,
						     nil, nil, nil,
						     nil, nil, nil}

		assert GameEngine.Board.resolve_winner(%GameEngine.Board{positions: back_diagonal_win}) == {:no_winner}
	end
end