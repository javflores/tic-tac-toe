defmodule GameEngine.KickAssPlayCenterMovesTest do
	use ExUnit.Case
	alias GameEngine.PlayStrategies.KickAssPlayCenterMoves, as: KickAssPlayCenterMoves

	@player :o
	@opponent :x

	test "play center if available" do
		board = %GameEngine.Board{positions: {nil, nil, nil,
						 					  nil, nil, nil,
						 					  nil, nil, nil}}

		move = KickAssPlayCenterMoves.find(board)

		assert move == %{row: 1, column: 1}
	end

	test "cannot take center when taken" do
		board = %GameEngine.Board{positions: {nil, nil, nil,
						 					  nil, @opponent, nil,
						 					  nil, nil, nil}}

		move = KickAssPlayCenterMoves.find(board)

		assert move == nil
	end
end