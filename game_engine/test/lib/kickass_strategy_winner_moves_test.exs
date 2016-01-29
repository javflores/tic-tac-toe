defmodule GameEngine.KickAssStrategyWinnerMovesTest do
	use ExUnit.Case

	test "winning horizontally horizontally taking first row and last column" do
		first_row_win = {:o, :o, nil,
						 nil, nil, nil,
						 :x, :x, nil}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: first_row_win}, :o)
			
		assert move == %{row: 0, column: 2}
	end

	test "winning horizontally taking first row and middle column" do
		first_row_win = {:o, nil, :o,
						 nil, nil, nil,
						 :x, :x, nil}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: first_row_win}, :o)
			
		assert move == %{row: 0, column: 1}
	end

	test "winning horizontally taking first row and first column" do
		first_row_win = {nil, :o, :o,
						 nil, :x, nil,
						 :x, nil, nil}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: first_row_win}, :o)
			
		assert move == %{row: 0, column: 0}
	end

	test "winning horizontally taking second row and last column" do
		second_row_win = {nil, nil, :x,
						 :o, :o, nil,
						 nil, :x, nil}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: second_row_win}, :o)
			
		assert move == %{row: 1, column: 2}
	end

	test "winning horizontally taking second row and middle column" do
		second_row_win = {nil, nil, nil,
						 :o, nil, :o,
						 nil, :x, :x}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: second_row_win}, :o)
			
		assert move == %{row: 1, column: 1}
	end

	test "winning horizontally taking second row and first column" do
		second_row_win = {:x, :x, nil,
						  nil, :o, :o,						 
						 nil, :x, nil}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: second_row_win}, :o)
			
		assert move == %{row: 1, column: 0}
	end

	test "winning horizontally taking third row and last column" do
		third_row_win = {nil, nil, :x,
						 nil, :x, nil,
						 :o, :o, nil}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: third_row_win}, :o)
			
		assert move == %{row: 2, column: 2}
	end

	test "winning horizontally taking third row and middle column" do
		third_row_win = {nil, :x, nil,
						 nil, :x, :x,
						 :o, nil, :o}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: third_row_win}, :o)
			
		assert move == %{row: 2, column: 1}
	end

	test "winning horizontally taking third row and first column" do
		third_row_win = {nil, nil, nil,
						 nil, nil, nil,
						 nil, :o, :o}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: third_row_win}, :o)
			
		assert move == %{row: 2, column: 0}
	end

	
	test "winning vertically horizontally taking first row and first column" do
		first_column_win = {nil, :x, nil,
						 	:o, nil, nil,
						 	:o, nil, nil}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: first_column_win}, :o)
			
		assert move == %{row: 0, column: 0}
	end

	test "winning vertically taking middle row and first column" do
		first_column_win = {:o, nil, nil,
						 	nil, nil, nil,
						    :o, nil, nil}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: first_column_win}, :o)
			
		assert move == %{row: 1, column: 0}
	end

	test "winning vertically taking last row and first column" do
		first_column_win = {:o, :x, :o,
						    :o, nil, nil,
						    nil, nil, nil}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: first_column_win}, :o)
			
		assert move == %{row: 2, column: 0}
	end

	test "winning vertically taking first row and second column" do
		second_column_win = {nil, nil, nil,
						 	 nil, :o, nil,
						     nil, :o, nil}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: second_column_win}, :o)
			
		assert move == %{row: 0, column: 1}
	end

	test "winning vertically taking middle row and second column" do
		second_column_win = {nil, :o, nil,
						     nil, nil, :o,
						     nil, :o, nil}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: second_column_win}, :o)
			
		assert move == %{row: 1, column: 1}
	end

	test "winning vertically taking last row and second column" do
		second_column_win = {nil, :o, nil,
						     nil, :o, nil,						 
						     nil, nil, nil}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: second_column_win}, :o)
			
		assert move == %{row: 2, column: 1}
	end

	test "winning vertically taking first row and last column" do
		third_column_win = {nil, nil, nil,
						 	nil, nil, :o,
						 	nil, nil, :o}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: third_column_win}, :o)
			
		assert move == %{row: 0, column: 2}
	end

	test "winning vertically taking middle row and last column" do
		third_column_win = {nil, nil, :o,
						 	nil, nil, nil,
						  	nil, nil, :o}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: third_column_win}, :o)
			
		assert move == %{row: 1, column: 2}
	end

	test "winning vertically taking last row and last column" do
		third_column_win = {nil, nil, :o,
						 	nil, nil, :o,
						 	nil, nil, nil}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: third_column_win}, :o)
			
		assert move == %{row: 2, column: 2}
	end

	test "winning diagonally taking top left corner" do
		diagonal_win = {nil, nil, :x,
						nil, :o, nil,
						:x, nil, :o}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: diagonal_win}, :o)
			
		assert move == %{row: 0, column: 0}
	end

	test "winning diagonally taking center" do
		diagonal_win = {:o, nil, :x,
						nil, nil, nil,
						:x, nil, :o}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: diagonal_win}, :o)
			
		assert move == %{row: 1, column: 1}
	end

	test "winning diagonally taking bottom right corner" do
		diagonal_win = {:o, nil, :x,
						nil, :o, nil,
						:x, nil, nil}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: diagonal_win}, :o)
			
		assert move == %{row: 2, column: 2}
	end

	test "winning diagonally taking top right corner" do
		diagonal_win = {nil, nil, nil,
						nil, :o, nil,
						:o, nil, nil}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: diagonal_win}, :o)
			
		assert move == %{row: 0, column: 2}
	end

	test "winning diagonally taking center with back diagonal" do
		diagonal_win = {nil, nil, :o,
						nil, nil, nil,
						:o, nil, nil}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: diagonal_win}, :o)
			
		assert move == %{row: 1, column: 1}
	end

	test "winning diagonally taking bottom left corner" do
		diagonal_win = {nil, nil, :o,
						nil, :o, nil,
						nil, nil, nil}

		move = GameEngine.KickAssStrategy.calculate_move(%GameEngine.Board{positions: diagonal_win}, :o)
			
		assert move == %{row: 2, column: 0}
	end
end