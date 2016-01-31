defmodule GameEngine.KickAssStrategyAbsoluteLocationMovesTest do
	use ExUnit.Case
	alias GameEngine.PlayStrategies.KickAssAbsoluteLocationMoves, as: KickAssAbsoluteLocationMoves

	test "play center if available" do
		board = %GameEngine.Board{positions: {nil, nil, nil,
						 					  nil, nil, nil,
						 					  nil, nil, nil}}

		move = KickAssAbsoluteLocationMoves.play_center(board)

		assert move == %{row: 1, column: 1}
	end

	test "cannot take center when taken" do
		board = %GameEngine.Board{positions: {nil, nil, nil,
						 					  nil, :x, nil,
						 					  nil, nil, nil}}

		move = KickAssAbsoluteLocationMoves.play_center(board)

		assert move == nil
	end
end