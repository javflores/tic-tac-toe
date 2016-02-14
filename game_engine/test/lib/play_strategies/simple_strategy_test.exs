defmodule GameEngine.SimpleStrategyTest do
	
	use ExUnit.Case

	import Mock

	test "find available positions in the board" do
		with_mock GameEngine.Board, [available_positions: fn(_board) -> [%{row: 0, column: 0}] end] do
			board = %GameEngine.Board{}

			GameEngine.PlayStrategies.SimpleStrategy.calculate_move(board)
			
			assert called GameEngine.Board.available_positions(board)
		end
	end

	test "provides available positions to random generator" do
		with_mock GameEngine.PlayStrategies.Moves.RandomPositions, [find: fn(_free_positions) -> %{row: 0, column: 1} end] do
			board_with_two_available_positions = {nil, :x, :o,
					 						  	  :x, :o, :o,
					                              :x, :o, nil}

			GameEngine.PlayStrategies.SimpleStrategy.calculate_move(%GameEngine.Board{positions: board_with_two_available_positions})
			
			assert called GameEngine.PlayStrategies.Moves.RandomPositions.find([%{row: 0, column: 0}, %{row: 2, column: 2}])
		end
	end
end