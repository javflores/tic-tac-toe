defmodule GameEngine.KickAssStrategyOpponentsOppositeCornerMovesTest do

	use ExUnit.Case
	alias GameEngine.PlayStrategies.KickAssOpponentsOppositeCornerMoves, as: KickAssOpponentsOppositeCornerMoves

	@player :o
	@opponent :x

	test "play bottom right corner opposite to opponents corner" do
		board = %GameEngine.Board{positions: {@opponent, nil, nil,
						 					  nil, @player, nil,
						 					  nil, nil, nil}}

		opposite_corner = KickAssOpponentsOppositeCornerMoves.find_corner(board, @opponent)

		assert opposite_corner == %{row: 2, column: 2}
	end

	test "play bottom left corner opposite to opponents corner" do
		board = %GameEngine.Board{positions: {nil, nil, @opponent,
						 					  nil, @player, nil,
						 					  nil, nil, nil}}

		opposite_corner = KickAssOpponentsOppositeCornerMoves.find_corner(board, @opponent)

		assert opposite_corner == %{row: 2, column: 0}
	end

	test "play top right corner opposite to opponents corner" do
		board = %GameEngine.Board{positions: {nil, nil, nil,
						 					  nil, @player, nil,
						 					  @opponent, nil, nil}}

		opposite_corner = KickAssOpponentsOppositeCornerMoves.find_corner(board, @opponent)

		assert opposite_corner == %{row: 0, column: 2}
	end

	test "play top left corner opposite to opponents corner" do
		board = %GameEngine.Board{positions: {nil, nil, nil,
						 					  nil, @player, nil,
						 					  nil, nil, @opponent}}

		opposite_corner = KickAssOpponentsOppositeCornerMoves.find_corner(board, @opponent)

		assert opposite_corner == %{row: 0, column: 0}
	end

	test "no corner available" do
		board = %GameEngine.Board{positions: {@player, nil, @player,
						 					  nil, @player, nil,
						 					  @opponent, nil, @opponent}}

		move = KickAssOpponentsOppositeCornerMoves.find_corner(board, @opponent)

		assert move == nil
	end
end