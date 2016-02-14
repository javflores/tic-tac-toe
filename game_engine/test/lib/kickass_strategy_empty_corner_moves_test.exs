defmodule GameEngine.KickAssStrategyEmptyCornerMovesTest do
	use ExUnit.Case
	alias GameEngine.PlayStrategies.KickAssEmptyCornerMoves, as: KickAssEmptyCornerMoves

	@player :o
	@opponent :x

	test "take empty top left corner" do
		board = %GameEngine.Board{positions: {nil, nil, nil,
						 					  nil, @opponent, nil,
						 					  nil, nil, nil}}

		move = KickAssEmptyCornerMoves.find(board)

		assert move == %{row: 0, column: 0}
	end

	test "take empty top right corner" do
		board = %GameEngine.Board{positions: {@player, nil, nil,
						 					  nil, @opponent, nil,
						 					  nil, nil, nil}}

		move = KickAssEmptyCornerMoves.find(board)

		assert move == %{row: 0, column: 2}
	end

	test "take empty bottom left corner" do
		board = %GameEngine.Board{positions: {@player, nil, @opponent,
						 					  nil, @opponent, nil,
						 					  nil, nil, nil}}

		move = KickAssEmptyCornerMoves.find(board)

		assert move == %{row: 2, column: 0}
	end

	test "take empty bottom right corner" do
		board = %GameEngine.Board{positions: {@player, nil, @opponent,
						 					  nil, @opponent, nil,
						 					  @player, nil, nil}}

		move = KickAssEmptyCornerMoves.find(board)

		assert move == %{row: 2, column: 2}
	end

	test "no empty corner to take" do
		board = %GameEngine.Board{positions: {@player, nil, @opponent,
						 					  nil, @opponent, nil,
						 					  @player, nil, @player}}

		move = KickAssEmptyCornerMoves.find(board)

		assert move == nil
	end
end