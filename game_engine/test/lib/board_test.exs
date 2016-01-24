defmodule GameEngine.BoardTest do
	use ExUnit.Case

	test "can get board with empty positions" do
		empty_positions = {nil, nil, nil,
						  nil, nil, nil,
						  nil, nil, nil}

		empty_board = %GameEngine.Board{}  

		assert empty_board.positions == empty_positions
	end
end