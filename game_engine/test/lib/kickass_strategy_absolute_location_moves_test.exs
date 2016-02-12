defmodule GameEngine.KickAssStrategyAbsoluteLocationMovesTest do
	use ExUnit.Case
	alias GameEngine.PlayStrategies.KickAssAbsoluteLocationMoves, as: KickAssAbsoluteLocationMoves

	@player :o
	@opponent :x

	test "play center if available" do
		board = %GameEngine.Board{positions: {nil, nil, nil,
						 					  nil, nil, nil,
						 					  nil, nil, nil}}

		move = KickAssAbsoluteLocationMoves.play_center(board)

		assert move == %{row: 1, column: 1}
	end

	test "cannot take center when taken" do
		board = %GameEngine.Board{positions: {nil, nil, nil,
						 					  nil, @opponent, nil,
						 					  nil, nil, nil}}

		move = KickAssAbsoluteLocationMoves.play_center(board)

		assert move == nil
	end

	test "take empty top left corner" do
		board = %GameEngine.Board{positions: {nil, nil, nil,
						 					  nil, @opponent, nil,
						 					  nil, nil, nil}}

		move = KickAssAbsoluteLocationMoves.take_empty_corner(board)

		assert move == %{row: 0, column: 0}
	end

	test "take empty top right corner" do
		board = %GameEngine.Board{positions: {@player, nil, nil,
						 					  nil, @opponent, nil,
						 					  nil, nil, nil}}

		move = KickAssAbsoluteLocationMoves.take_empty_corner(board)

		assert move == %{row: 0, column: 2}
	end

	test "take empty bottom left corner" do
		board = %GameEngine.Board{positions: {@player, nil, @opponent,
						 					  nil, @opponent, nil,
						 					  nil, nil, nil}}

		move = KickAssAbsoluteLocationMoves.take_empty_corner(board)

		assert move == %{row: 2, column: 0}
	end

	test "take empty bottom right corner" do
		board = %GameEngine.Board{positions: {@player, nil, @opponent,
						 					  nil, @opponent, nil,
						 					  @player, nil, nil}}

		move = KickAssAbsoluteLocationMoves.take_empty_corner(board)

		assert move == %{row: 2, column: 2}
	end

	test "no empty corner to take" do
		board = %GameEngine.Board{positions: {@player, nil, @opponent,
						 					  nil, @opponent, nil,
						 					  @player, nil, @player}}

		move = KickAssAbsoluteLocationMoves.take_empty_corner(board)

		assert move == nil
	end

	test "take empty top side" do
		board = %GameEngine.Board{positions: {@opponent, nil, @player,
						 					  nil, @opponent, nil,
						 					  @player, nil, @player}}

		move = KickAssAbsoluteLocationMoves.take_empty_side(board)

		assert move == %{row: 0, column: 1}
	end

	test "take empty left side" do
		board = %GameEngine.Board{positions: {@player, @player, @opponent,
						 					  nil, @opponent, nil,
						 					  @opponent, nil, @opponent}}

		move = KickAssAbsoluteLocationMoves.take_empty_side(board)

		assert move == %{row: 1, column: 0}
	end

	test "take empty right side" do
		board = %GameEngine.Board{positions: {@player, @player, @opponent,
						 					  @player, @opponent, nil,
						 					  @player, nil, @player}}

		move = KickAssAbsoluteLocationMoves.take_empty_side(board)

		assert move == %{row: 1, column: 2}
	end

	test "take empty bottom side" do
		board = %GameEngine.Board{positions: {@player, @player, @opponent,
						 					  @player, @opponent, @opponent,
						 					  @player, nil, @player}}

		move = KickAssAbsoluteLocationMoves.take_empty_side(board)

		assert move == %{row: 2, column: 1}
	end
end