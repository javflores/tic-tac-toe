defmodule GameEngine.PlayStrategies.Moves.ForkTest do
	use ExUnit.Case
	alias GameEngine.PlayStrategies.Moves.Fork, as: Fork

	@player :o
	@opponent :x

	test "find fork as an empty space included in two triples with two empty spaces" do
		positions_with_fork = {@player, @opponent, nil,
								nil, @player, nil,
								nil, nil, @opponent}

		fork = Fork.find(%GameEngine.Board{positions: positions_with_fork}, @player)

		expected_fork = %{row: 1, column: 0}		
		assert fork == expected_fork
	end

	test "able to find all forks" do
		position_with_several_forks = {@opponent, @opponent, nil,
										nil, @player, nil,
										nil, nil, @player}

		forks = Fork.find_all(%GameEngine.Board{positions: position_with_several_forks}, @player)

		all_forks = [%{column: 2, row: 1}, %{column: 2, row: 0}, %{column: 0, row: 2}]
		assert forks == all_forks
	end

	test "find really early fork" do
		early_fork = {@opponent, nil, nil,
					  nil, @player, nil,
					  nil, @opponent, @player}

		move = Fork.find(%GameEngine.Board{positions: early_fork}, @player)

		expected_fork = %{row: 1, column: 2}		
		assert move == expected_fork
	end
end