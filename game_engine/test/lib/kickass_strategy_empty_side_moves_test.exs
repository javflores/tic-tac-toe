defmodule GameEngine.KickAssStrategyEmptySideMovesTest do
	use ExUnit.Case
	alias GameEngine.PlayStrategies.KickAssEmptySideMoves, as: KickAssEmptySideMoves

	@player :o
	@opponent :x

	test "take empty top side" do
		board = %GameEngine.Board{positions: {@opponent, nil, @player,
						 					  nil, @opponent, nil,
						 					  @player, nil, @player}}

		move = KickAssEmptySideMoves.find(board)

		assert move == %{row: 0, column: 1}
	end

	test "take empty left side" do
		board = %GameEngine.Board{positions: {@player, @player, @opponent,
						 					  nil, @opponent, nil,
						 					  @opponent, nil, @opponent}}

		move = KickAssEmptySideMoves.find(board)

		assert move == %{row: 1, column: 0}
	end

	test "take empty right side" do
		board = %GameEngine.Board{positions: {@player, @player, @opponent,
						 					  @player, @opponent, nil,
						 					  @player, nil, @player}}

		move = KickAssEmptySideMoves.find(board)

		assert move == %{row: 1, column: 2}
	end

	test "take empty bottom side" do
		board = %GameEngine.Board{positions: {@player, @player, @opponent,
						 					  @player, @opponent, @opponent,
						 					  @player, nil, @player}}

		move = KickAssEmptySideMoves.find(board)

		assert move == %{row: 2, column: 1}
	end
end