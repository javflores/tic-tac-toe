defmodule GameEngine.KickAssStrategyForceDefendingMovesTest do
	use ExUnit.Case
	alias GameEngine.PlayStrategies.KickAssForceDefendingMoves, as: KickAssForceDefendingMoves

	@player :o
	@opponent :x

	test "find top left corner in rows" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_rows([{[nil, nil, @player], 0}])

		assert found_corners == [%{row: 0, column: 0}]
	end

	test "find top left corner when user has taken middle possition in rows" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_rows([{[nil, @player, nil], 0}])

		assert found_corners == [%{row: 0, column: 0}]
	end

	test "find top right corner in rows" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_rows([{[@player, nil, nil], 0}])

		assert found_corners == [%{row: 0, column: 2}]
	end

	test "find bottom left corner in rows" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_rows([{[nil, nil, @player], 2}])

		assert found_corners == [%{row: 2, column: 0}]
	end

	test "find bottom left corner when user has taken middle possition in rows" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_rows([{[nil, @player, nil], 2}])

		assert found_corners == [%{row: 2, column: 0}]
	end

	test "cornes are not available in the middle row" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_rows([{[nil, @player, nil], 1}])

		assert found_corners == []
	end

	test "find bottom right corner in rows" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_rows([{[@player, nil, nil], 2}])

		assert found_corners == [%{row: 2, column: 2}]
	end

	test "find several corners in rows" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_rows([{[nil, nil, @player], 0}, {[@player, nil, nil], 2}])

		assert found_corners == [%{row: 0, column: 0}, %{row: 2, column: 2}]
	end

	test "find top left corner in columns" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_columns([{[nil, nil, @player], 0}])

		assert found_corners == [%{row: 0, column: 0}]
	end

	test "find top left corner when user has taken middle possition in columns" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_columns([{[nil, @player, nil], 0}])

		assert found_corners == [%{row: 0, column: 0}]
	end

	test "find bottom left corner in columns" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_columns([{[@player, nil, nil], 0}])

		assert found_corners == [%{row: 2, column: 0}]
	end

	test "find top right corner in columns" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_columns([{[nil, nil, @player], 2}])

		assert found_corners == [%{row: 0, column: 2}]
	end

	test "find bottom right corner when user has taken middle possition in columns" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_columns([{[nil, @player, nil], 2}])

		assert found_corners == [%{row: 0, column: 2}]
	end

	test "cornes are not available in the middle column" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_columns([{[nil, @player, nil], 1}])

		assert found_corners == []
	end

	test "find bottom right corner in columns" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_columns([{[@player, nil, nil], 2}])

		assert found_corners == [%{row: 2, column: 2}]
	end

	test "find several corners in columns" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_columns([{[nil, nil, @player], 0}, {[@player, nil, nil], 2}])

		assert found_corners == [%{row: 0, column: 0}, %{row: 2, column: 2}]
	end

	test "find top left corner in diagonal" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_diagonals([{[nil, nil, @player], 0}])

		assert found_corners == [%{row: 0, column: 0}]
	end

	test "find top left corner when user has taken middle possition in diagonal" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_diagonals([{[nil, @player, nil], 0}])

		assert found_corners == [%{row: 0, column: 0}]
	end

	test "find bottom right corner in diagonal" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_diagonals([{[@player, nil, nil], 0}])

		assert found_corners == [%{row: 2, column: 2}]
	end

	test "find top right corner in back diagonal" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_diagonals([{[nil, nil, @player], 1}])

		assert found_corners == [%{row: 0, column: 2}]
	end

	test "find top right corner when user has taken middle possition in back diagonal" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_diagonals([{[nil, @player, nil], 1}])

		assert found_corners == [%{row: 0, column: 2}]
	end

	test "find bottom left corner in back diagonal" do
		found_corners = KickAssForceDefendingMoves.find_corners_in_diagonals([{[@player, nil, nil], 1}])

		assert found_corners == [%{row: 2, column: 0}]
	end

	test "find corners for board triples" do
		board_triples = %{rows: [{[nil, nil, @player], 0}, {[nil, nil, @player], 1}], columns: [{[nil, nil, @player], 0}], diagonals: [{[nil, nil, @player], 0}]}
		found_corners = KickAssForceDefendingMoves.find_corners(board_triples)

		assert found_corners == [%{row: 0, column: 0}]
	end

	test "play empty corner belonging to triple with two empty spaces and one mark by player" do
		positions = {nil, @opponent, nil,
					 nil, @player, nil,
					 nil, nil, nil}

		position_to_play = KickAssForceDefendingMoves.force_defending(%GameEngine.Board{positions: positions}, @player)

		expected_force_defending = %{row: 0, column: 0}		
		assert position_to_play == expected_force_defending
	end

	test "o finds x as opponent in order to know about his possible future movements" do
		assert KickAssForceDefendingMoves.know_your_enemy(@player) == @opponent
	end

	test "x finds o as opponent in order to know about his possible future movements" do
		assert KickAssForceDefendingMoves.know_your_enemy(@opponent) == @player
	end

	test "finds possible opponents fork for a force-defending move" do
		board = %GameEngine.Board{positions: {@opponent, nil, nil,
					 						  nil, @player, nil,
					 						  nil, nil, @opponent}}
		force_defending_move = %{row: 0, column: 2}

		assert KickAssForceDefendingMoves.results_in_opponents_fork?(force_defending_move, board, @player) == true
	end

	test "filter force-defending move leading to opponents fork" do
		positions = {@opponent, nil, nil,
					 nil, @player, nil,
					 nil, nil, @opponent}
		force_defending_move = %{row: 0, column: 2}
		list_of_moves = [force_defending_move]

		filtered_moves = KickAssForceDefendingMoves.filter_possible_opponents_forks(list_of_moves, %GameEngine.Board{positions: positions}, @player)

		assert filtered_moves == []
	end

	test "refutes moves leading to opponent's fork in response to a force-defence move" do
		positions = {@opponent, nil, nil,
					 nil, @player, nil,
					 nil, nil, @opponent}

		position_to_play = KickAssForceDefendingMoves.force_defending(%GameEngine.Board{positions: positions}, @player)

		position_leading_to_opponents_fork = %{row: 0, column: 2}		
		refute position_to_play == position_leading_to_opponents_fork
	end
end
