defmodule GameEngine.KickAssStrategyAttackOpponentsForkMovesTest do
	use ExUnit.Case
	alias GameEngine.PlayStrategies.KickAssAttackOpponentsForkMoves, as: AttackOpponentsFork

	@player :o
	@opponent :x

 	test "do not attack fork if opponent does not have any forks" do
		board_with_no_opponents_forks = {@player, nil, nil,
							 			 nil, @opponent, nil,
						     			 nil, nil, @player}

		attack_fork = AttackOpponentsFork.find(%GameEngine.Board{positions: board_with_no_opponents_forks}, @player)

		assert attack_fork == nil
	end


	test "attack opponents fork by forcing to defend" do
		board_with_two_opponents_forks = {@player, nil, nil,
							 			  nil, @opponent, nil,
						     			  nil, nil, @opponent}

		attack_fork = AttackOpponentsFork.find(%GameEngine.Board{positions: board_with_two_opponents_forks}, @player)

		assert attack_fork == %{row: 0, column: 2}
	end

	test "do not attack opponents fork with position that still leads to fork" do
		board_with_two_opponents_forks = {nil, nil, @opponent,
							 			  nil, @player, nil,
						     			  @opponent, nil, nil}

		attack_fork = AttackOpponentsFork.find(%GameEngine.Board{positions: board_with_two_opponents_forks}, @player)
		
		weak_attack_fork = %{row: 0, column: 0}
		refute attack_fork == weak_attack_fork
	end

	test "finds all attack opponents forks" do
		board_with_two_opponents_forks = {nil, nil, @opponent,
							 			  nil, @player, nil,
						     			  @opponent, nil, nil}

		moves = AttackOpponentsFork.find_all(%GameEngine.Board{positions: board_with_two_opponents_forks}, @player)
		
		assert moves == [%{column: 0, row: 1}, %{column: 2, row: 1}, 
						 %{column: 1, row: 0}, %{column: 1, row: 2}]
	end
end