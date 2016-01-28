defmodule GameEngine.SimpleStrategyTest do
	
	use ExUnit.Case

	import Mock

	test "find available positions in the board" do
		with_mock GameEngine.Board, [available_positions: fn(_board) -> [%{row: 0, column: 0}] end] do
			board = %GameEngine.Board{}

			GameEngine.SimpleStrategy.calculate_move(board)
			
			assert called GameEngine.Board.available_positions(board)
		end
	end
end