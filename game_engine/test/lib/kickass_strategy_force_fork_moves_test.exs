defmodule GameEngine.KickAssStrategyForceForkMovesTest do
	use ExUnit.Case
	alias GameEngine.PlayStrategies.KickAssForceForkMoves, as: KickAssForceForkMoves

	@player :o
	@opponent :x

	test "find top left corner in rows" do
		found_corners = KickAssForceForkMoves.find_corners_in_rows([{[nil, nil, @player], 0}])

		assert found_corners == [%{row: 0, column: 0}]
	end

	test "find top left corner when user has taken middle possition in rows" do
		found_corners = KickAssForceForkMoves.find_corners_in_rows([{[nil, @player, nil], 0}])

		assert found_corners == [%{row: 0, column: 0}, %{column: 2, row: 0}]
	end

	test "find top right corner in rows" do
		found_corners = KickAssForceForkMoves.find_corners_in_rows([{[@player, nil, nil], 0}])

		assert found_corners == [%{row: 0, column: 2}]
	end

	test "find bottom left corner in rows" do
		found_corners = KickAssForceForkMoves.find_corners_in_rows([{[nil, nil, @player], 2}])

		assert found_corners == [%{row: 2, column: 0}]
	end

	test "find bottom left corner when user has taken middle possition in rows" do
		found_corners = KickAssForceForkMoves.find_corners_in_rows([{[nil, @player, nil], 2}])

		assert found_corners == [%{row: 2, column: 0}, %{column: 2, row: 2}]
	end

	test "cornes are not available in the middle row" do
		found_corners = KickAssForceForkMoves.find_corners_in_rows([{[nil, @player, nil], 1}])

		assert found_corners == []
	end

	test "find bottom right corner in rows" do
		found_corners = KickAssForceForkMoves.find_corners_in_rows([{[@player, nil, nil], 2}])

		assert found_corners == [%{row: 2, column: 2}]
	end

	test "find several corners in rows" do
		found_corners = KickAssForceForkMoves.find_corners_in_rows([{[nil, nil, @player], 0}, {[@player, nil, nil], 2}])

		assert found_corners == [%{row: 0, column: 0}, %{row: 2, column: 2}]
	end

	test "find top left corner in columns" do
		found_corners = KickAssForceForkMoves.find_corners_in_columns([{[nil, nil, @player], 0}])

		assert found_corners == [%{row: 0, column: 0}]
	end

	test "find top left corner when user has taken middle possition in columns" do
		found_corners = KickAssForceForkMoves.find_corners_in_columns([{[nil, @player, nil], 0}])

		assert found_corners == [%{row: 0, column: 0}, %{column: 0, row: 2}]
	end

	test "find bottom left corner in columns" do
		found_corners = KickAssForceForkMoves.find_corners_in_columns([{[@player, nil, nil], 0}])

		assert found_corners == [%{row: 2, column: 0}]
	end

	test "find top right corner in columns" do
		found_corners = KickAssForceForkMoves.find_corners_in_columns([{[nil, nil, @player], 2}])

		assert found_corners == [%{row: 0, column: 2}]
	end

	test "find bottom right corner when user has taken middle possition in columns" do
		found_corners = KickAssForceForkMoves.find_corners_in_columns([{[nil, @player, nil], 2}])

		assert found_corners == [%{row: 0, column: 2}, %{column: 2, row: 2}]
	end

	test "cornes are not available in the middle column" do
		found_corners = KickAssForceForkMoves.find_corners_in_columns([{[nil, @player, nil], 1}])

		assert found_corners == []
	end

	test "find bottom right corner in columns" do
		found_corners = KickAssForceForkMoves.find_corners_in_columns([{[@player, nil, nil], 2}])

		assert found_corners == [%{row: 2, column: 2}]
	end

	test "find several corners in columns" do
		found_corners = KickAssForceForkMoves.find_corners_in_columns([{[nil, nil, @player], 0}, {[@player, nil, nil], 2}])

		assert found_corners == [%{row: 0, column: 0}, %{row: 2, column: 2}]
	end

	test "find top left corner in diagonal" do
		found_corners = KickAssForceForkMoves.find_corners_in_diagonals([{[nil, nil, @player], 0}])

		assert found_corners == [%{row: 0, column: 0}]
	end

	test "find top left corner when user has taken middle possition in diagonal" do
		found_corners = KickAssForceForkMoves.find_corners_in_diagonals([{[nil, @player, nil], 0}])

		assert found_corners == [%{row: 0, column: 0}, %{column: 2, row: 2}]
	end

	test "find bottom right corner in diagonal" do
		found_corners = KickAssForceForkMoves.find_corners_in_diagonals([{[@player, nil, nil], 0}])

		assert found_corners == [%{row: 2, column: 2}]
	end

	test "find top right corner in back diagonal" do
		found_corners = KickAssForceForkMoves.find_corners_in_diagonals([{[nil, nil, @player], 1}])

		assert found_corners == [%{row: 0, column: 2}]
	end

	test "find top right corner when user has taken middle possition in back diagonal" do
		found_corners = KickAssForceForkMoves.find_corners_in_diagonals([{[nil, @player, nil], 1}])

		assert found_corners == [%{row: 0, column: 2}, %{column: 0, row: 2}]
	end

	test "find bottom left corner in back diagonal" do
		found_corners = KickAssForceForkMoves.find_corners_in_diagonals([{[@player, nil, nil], 1}])

		assert found_corners == [%{row: 2, column: 0}]
	end

	test "find corners for board triples" do
		board_triples = %{rows: [{[nil, nil, @player], 0}, {[nil, nil, @player], 1}], columns: [{[nil, nil, @player], 0}], diagonals: [{[nil, nil, @player], 0}]}
		found_corners = KickAssForceForkMoves.find_corners(board_triples)

		assert found_corners == [%{row: 0, column: 0}]
	end

	test "o finds x as opponent in order to know about his possible future movements" do
		assert KickAssForceForkMoves.know_your_enemy(@player) == @opponent
	end

	test "x finds o as opponent in order to know about his possible future movements" do
		assert KickAssForceForkMoves.know_your_enemy(@opponent) == @player
	end

	test "finds possible opponents fork after trying to force a fork" do
		board = %GameEngine.Board{positions: {@opponent, nil, nil,
					 						  nil, @player, nil,
					 						  nil, nil, @opponent}}
		force_fork_move = %{row: 0, column: 2}

		assert KickAssForceForkMoves.results_in_opponents_fork?(force_fork_move, board, @player) == true
	end

	test "filter force-fork move leading to opponents fork" do
		positions = {@opponent, nil, nil,
					 nil, @player, nil,
					 nil, nil, @opponent}
		possible_force_fork_move = %{row: 0, column: 2}
		list_of_moves = [possible_force_fork_move]

		filtered_moves = KickAssForceForkMoves.filter_possible_opponents_forks(list_of_moves, %GameEngine.Board{positions: positions}, @player)

		assert filtered_moves == []
	end

	test "refutes moves leading to opponent's fork in response to a force-defence move" do
		positions = {@opponent, nil, nil,
					 nil, @player, nil,
					 nil, nil, @opponent}

		possible_force_fork_move = KickAssForceForkMoves.force_fork(%GameEngine.Board{positions: positions}, @player)

		position_leading_to_opponents_fork = %{row: 0, column: 2}		
		refute possible_force_fork_move == position_leading_to_opponents_fork
	end

	test "filter force-fork move not leading to subsequent player fork" do
		positions = {@opponent, nil, @opponent,
					 nil, @player, nil,
					 nil, nil, @player}
		possible_force_fork_move = %{row: 2, column: 0}
		list_of_moves = [possible_force_fork_move]

		filtered_moves = KickAssForceForkMoves.filter_moves_not_leading_to_fork(list_of_moves, %GameEngine.Board{positions: positions}, @player)

		assert filtered_moves == []
	end

	test "finds a force fork move involving opponents defence and later fork" do
		positions = {nil, @opponent, nil,
					 nil, @player, nil,
					 nil, nil, nil}

		move = KickAssForceForkMoves.force_fork(%GameEngine.Board{positions: positions}, @player)

		assert move == %{row: 0, column: 0}
	end
end
