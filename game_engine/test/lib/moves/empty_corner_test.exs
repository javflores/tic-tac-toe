defmodule GameEngine.PlayStrategies.Moves.EmptyCornerTest do
	use ExUnit.Case
	alias GameEngine.PlayStrategies.Moves.EmptyCorner, as: EmptyCorner

	@player :o
	@opponent :x

	test "take empty top left corner" do
		board = %GameEngine.Board{positions: {nil, nil, nil,
						 					  nil, @opponent, nil,
						 					  nil, nil, nil}}

		move = EmptyCorner.find(board)

		assert move == %{row: 0, column: 0}
	end

	test "take empty top right corner" do
		board = %GameEngine.Board{positions: {@player, nil, nil,
						 					  nil, @opponent, nil,
						 					  nil, nil, nil}}

		move = EmptyCorner.find(board)

		assert move == %{row: 0, column: 2}
	end

	test "take empty bottom left corner" do
		board = %GameEngine.Board{positions: {@player, nil, @opponent,
						 					  nil, @opponent, nil,
						 					  nil, nil, nil}}

		move = EmptyCorner.find(board)

		assert move == %{row: 2, column: 0}
	end

	test "take empty bottom right corner" do
		board = %GameEngine.Board{positions: {@player, nil, @opponent,
						 					  nil, @opponent, nil,
						 					  @player, nil, nil}}

		move = EmptyCorner.find(board)

		assert move == %{row: 2, column: 2}
	end

	test "no empty corner to take" do
		board = %GameEngine.Board{positions: {@player, nil, @opponent,
						 					  nil, @opponent, nil,
						 					  @player, nil, @player}}

		move = EmptyCorner.find(board)

		assert move == nil
	end
end