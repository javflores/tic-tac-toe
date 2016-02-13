defmodule GameEngine.KickAssStrategyForkMovesTest do
	use ExUnit.Case
	alias GameEngine.PlayStrategies.KickAssForkMoves, as: KickAssForkMoves

	@player :o
	@opponent :x

	test "find fork as an empty space included in two triples with two empty spaces" do
		positions_with_fork_in_bottom_left_corner = {@player, @opponent, nil,
													 nil, @player, nil,
													 nil, nil, @opponent}

		fork = KickAssForkMoves.fork(%GameEngine.Board{positions: positions_with_fork_in_bottom_left_corner}, @player)

		expected_fork = %{row: 1, column: 0}		
		assert fork == expected_fork
	end

	test "find really early fork" do
		early_fork = {@opponent, nil, nil,
					  nil, @player, nil,
					  nil, @opponent, @player}

		move = KickAssForkMoves.fork(%GameEngine.Board{positions: early_fork}, @player)

		expected_fork = %{row: 1, column: 2}		
		assert move == expected_fork
	end
end