defmodule GameEngine.KickAssAttackMovesTest do
	use ExUnit.Case
	alias GameEngine.PlayStrategies.KickAssAttackMoves, as: KickAssAttackMoves

	@player :o
	@opponent :x

	test "finds non-duplicated triples with two empty positions and one position by players" do
		board_triples = %{rows: [{[nil, nil, @player], 0}, {[nil, nil, @player], 1}], 
						  columns: [{[nil, nil, @player], 0}], 
						  diagonals: [{[nil, nil, @player], 0}]}
		non_duplicated = KickAssAttackMoves.filter_non_duplicated(board_triples)

		assert non_duplicated == [%{row: 0, column: 0}, %{row: 0, column: 1}, 
								  %{row: 1, column: 0}, %{row: 1, column: 1}]
	end

	test "atacks fork by forcing opponent into defending" do
		positions = {@player, nil, nil,
					 nil, @opponent, nil,
					 nil, nil, @opponent}

		move = KickAssAttackMoves.find(%GameEngine.Board{positions: positions}, @player)

		assert move == %{row: 0, column: 1}
	end

	test "refutes moves leading to opponent's fork in response to a force-defence move" do
		positions = {@opponent, nil, nil,
					 nil, @player, nil,
					 nil, nil, @opponent}

		possible_force_fork_move = KickAssAttackMoves.find(%GameEngine.Board{positions: positions}, @player)

		position_leading_to_opponents_fork = %{row: 0, column: 2}		
		refute possible_force_fork_move == position_leading_to_opponents_fork
	end

	test "filter moves leading to opponents fork" do
		positions = {@opponent, nil, nil,
					 nil, @player, nil,
					 nil, nil, @opponent}
		possible_force_fork_move = %{row: 0, column: 2}
		list_of_moves = [possible_force_fork_move]

		filtered_moves = KickAssAttackMoves.filter_possible_opponents_forks(list_of_moves, %GameEngine.Board{positions: positions}, @player)

		assert filtered_moves == []
	end

	test "finds not-safe defence leading to opponents" do
		board = %GameEngine.Board{positions: {@opponent, nil, nil,
					 						  nil, @player, nil,
					 						  nil, nil, @opponent}}
		force_fork_move = %{row: 0, column: 2}

		assert KickAssAttackMoves.is_safe_defence?(force_fork_move, board, @player) == false
	end	

	test "o finds x as opponent in order to know about his possible future movements" do
		assert KickAssAttackMoves.know_your_enemy(@player) == @opponent
	end

	test "x finds o as opponent in order to know about his possible future movements" do
		assert KickAssAttackMoves.know_your_enemy(@opponent) == @player
	end
end
