defmodule GameEngine.KickAssStrategyForceForkMovesTest do
	use ExUnit.Case
	alias GameEngine.PlayStrategies.KickAssForceForkMoves, as: KickAssForceForkMoves

	@player :o
	@opponent :x

	test "not able to force fork if no attack positions are left" do
		possible_force_fork_move = nil

		filtered_moves = KickAssForceForkMoves.move_leading_to_own_fork(possible_force_fork_move, %GameEngine.Board{positions: {}}, @player)

		assert filtered_moves == nil
	end
	
	test "filters attack not leading to subsequent player fork" do
		positions = {@opponent, nil, @opponent,
					 nil, @player, nil,
					 nil, nil, @player}
		possible_force_fork_move = %{row: 2, column: 0}

		filtered_moves = KickAssForceForkMoves.move_leading_to_own_fork(possible_force_fork_move, %GameEngine.Board{positions: positions}, @player)

		assert filtered_moves == nil
	end

	test "filters all attacks not leading to subsequent player fork" do
		positions = {@opponent, nil, nil,
					 nil, @player, nil,
					 nil, nil, nil}
		possible_attacks  = [%{row: 0, column: 1}]

		filtered_moves = KickAssForceForkMoves.move_leading_to_own_fork(possible_attacks, %GameEngine.Board{positions: positions}, @player)

		assert filtered_moves == nil
	end

	test "finds a force fork move involving opponents defence and later fork" do
		positions = {nil, @opponent, nil,
					 nil, @player, nil,
					 nil, nil, nil}

		move = KickAssForceForkMoves.find(%GameEngine.Board{positions: positions}, @player)

		assert move == %{row: 1, column: 0}
	end
end
