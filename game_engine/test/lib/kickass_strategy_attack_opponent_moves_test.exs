defmodule GameEngine.KickAssAttackMovesTest do
	use ExUnit.Case
	alias GameEngine.PlayStrategies.KickAssAttackMoves, as: KickAssAttackMoves

	@player :o
	@opponent :x

	test "prevents fork by forcing opponent into defending" do
		positions = {@player, nil, nil,
					 nil, @opponent, nil,
					 nil, nil, @opponent}

		move = KickAssAttackMoves.find(%GameEngine.Board{positions: positions}, @player)

		assert move == %{row: 0, column: 2}
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

	test "finds corners for board triples" do
		board_triples = %{rows: [{[nil, nil, @player], 0}, {[nil, nil, @player], 1}], 
						  columns: [{[nil, nil, @player], 0}], 
						  diagonals: [{[nil, nil, @player], 0}]}
		found_corners = KickAssAttackMoves.find_corners(board_triples, @player)

		assert found_corners == [%{row: 0, column: 0}]
	end

	test "find top left corner in rows" do
		found_corners = KickAssAttackMoves.find_corners_in_rows([{[nil, nil, @player], 0}], @player)

		assert found_corners == [%{row: 0, column: 0}]
	end

	test "find top left corner when user has taken middle possition in rows" do
		found_corners = KickAssAttackMoves.find_corners_in_rows([{[nil, @player, nil], 0}], @player)

		assert found_corners == [%{row: 0, column: 0}, %{column: 2, row: 0}]
	end

	test "find top right corner in rows" do
		found_corners = KickAssAttackMoves.find_corners_in_rows([{[@player, nil, nil], 0}], @player)

		assert found_corners == [%{row: 0, column: 2}]
	end

	test "find bottom left corner in rows" do
		found_corners = KickAssAttackMoves.find_corners_in_rows([{[nil, nil, @player], 2}], @player)

		assert found_corners == [%{row: 2, column: 0}]
	end

	test "find bottom left corner when user has taken middle possition in rows" do
		found_corners = KickAssAttackMoves.find_corners_in_rows([{[nil, @player, nil], 2}], @player)

		assert found_corners == [%{row: 2, column: 0}, %{column: 2, row: 2}]
	end

	test "cornes are not available in the middle row" do
		found_corners = KickAssAttackMoves.find_corners_in_rows([{[nil, @player, nil], 1}], @player)

		assert found_corners == []
	end

	test "find bottom right corner in rows" do
		found_corners = KickAssAttackMoves.find_corners_in_rows([{[@player, nil, nil], 2}], @player)

		assert found_corners == [%{row: 2, column: 2}]
	end

	test "find several corners in rows" do
		found_corners = KickAssAttackMoves.find_corners_in_rows([{[nil, nil, @player], 0}, {[@player, nil, nil], 2}], @player)

		assert found_corners == [%{row: 0, column: 0}, %{row: 2, column: 2}]
	end

	test "find top left corner in columns" do
		found_corners = KickAssAttackMoves.find_corners_in_columns([{[nil, nil, @player], 0}], @player)

		assert found_corners == [%{row: 0, column: 0}]
	end

	test "find top left corner when user has taken middle possition in columns" do
		found_corners = KickAssAttackMoves.find_corners_in_columns([{[nil, @player, nil], 0}], @player)

		assert found_corners == [%{row: 0, column: 0}, %{column: 0, row: 2}]
	end

	test "find bottom left corner in columns" do
		found_corners = KickAssAttackMoves.find_corners_in_columns([{[@player, nil, nil], 0}], @player)

		assert found_corners == [%{row: 2, column: 0}]
	end

	test "find top right corner in columns" do
		found_corners = KickAssAttackMoves.find_corners_in_columns([{[nil, nil, @player], 2}], @player)

		assert found_corners == [%{row: 0, column: 2}]
	end

	test "find bottom right corner when user has taken middle possition in columns" do
		found_corners = KickAssAttackMoves.find_corners_in_columns([{[nil, @player, nil], 2}], @player)

		assert found_corners == [%{row: 0, column: 2}, %{column: 2, row: 2}]
	end

	test "cornes are not available in the middle column" do
		found_corners = KickAssAttackMoves.find_corners_in_columns([{[nil, @player, nil], 1}], @player)

		assert found_corners == []
	end

	test "find bottom right corner in columns" do
		found_corners = KickAssAttackMoves.find_corners_in_columns([{[@player, nil, nil], 2}], @player)

		assert found_corners == [%{row: 2, column: 2}]
	end

	test "find several corners in columns" do
		found_corners = KickAssAttackMoves.find_corners_in_columns([{[nil, nil, @player], 0}, {[@player, nil, nil], 2}], @player)

		assert found_corners == [%{row: 0, column: 0}, %{row: 2, column: 2}]
	end

	test "find top left corner in diagonal" do
		found_corners = KickAssAttackMoves.find_corners_in_diagonals([{[nil, nil, @player], 0}], @player)

		assert found_corners == [%{row: 0, column: 0}]
	end

	test "find top left corner when user has taken middle possition in diagonal" do
		found_corners = KickAssAttackMoves.find_corners_in_diagonals([{[nil, @player, nil], 0}], @player)

		assert found_corners == [%{row: 0, column: 0}, %{column: 2, row: 2}]
	end

	test "find bottom right corner in diagonal" do
		found_corners = KickAssAttackMoves.find_corners_in_diagonals([{[@player, nil, nil], 0}], @player)

		assert found_corners == [%{row: 2, column: 2}]
	end

	test "find top right corner in back diagonal" do
		found_corners = KickAssAttackMoves.find_corners_in_diagonals([{[nil, nil, @player], 1}], @player)

		assert found_corners == [%{row: 0, column: 2}]
	end

	test "find top right corner when user has taken middle possition in back diagonal" do
		found_corners = KickAssAttackMoves.find_corners_in_diagonals([{[nil, @player, nil], 1}], @player)

		assert found_corners == [%{row: 0, column: 2}, %{column: 0, row: 2}]
	end

	test "find bottom left corner in back diagonal" do
		found_corners = KickAssAttackMoves.find_corners_in_diagonals([{[@player, nil, nil], 1}], @player)

		assert found_corners == [%{row: 2, column: 0}]
	end

	test "o finds x as opponent in order to know about his possible future movements" do
		assert KickAssAttackMoves.know_your_enemy(@player) == @opponent
	end

	test "x finds o as opponent in order to know about his possible future movements" do
		assert KickAssAttackMoves.know_your_enemy(@opponent) == @player
	end
end
