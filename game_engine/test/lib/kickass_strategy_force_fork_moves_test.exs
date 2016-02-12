defmodule GameEngine.KickAssStrategyForceForkMovesTest do
	use ExUnit.Case
	alias GameEngine.PlayStrategies.KickAssForceForkMoves, as: KickAssForceForkMoves

	@player :o
	@opponent :x

	test "o finds x as opponent in order to know about his possible future movements" do
		assert KickAssForceForkMoves.know_your_enemy(@player) == @opponent
	end

	test "x finds o as opponent in order to know about his possible future movements" do
		assert KickAssForceForkMoves.know_your_enemy(@opponent) == @player
	end

	test "filter force-fork move not leading to subsequent player fork" do
		positions = {@opponent, nil, @opponent,
					 nil, @player, nil,
					 nil, nil, @player}
		possible_force_fork_move = %{row: 2, column: 0}

		filtered_moves = KickAssForceForkMoves.filter_moves_not_leading_to_fork(possible_force_fork_move, %GameEngine.Board{positions: positions}, @player)

		assert filtered_moves == nil
	end

	test "finds a force fork move involving opponents defence and later fork" do
		positions = {nil, @opponent, nil,
					 nil, @player, nil,
					 nil, nil, nil}

		move = KickAssForceForkMoves.force_fork(%GameEngine.Board{positions: positions}, @player)

		assert move == %{row: 0, column: 0}
	end
end
