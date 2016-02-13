defmodule GameEngine.PlayStrategies.KickAssAttackMoves do
	def find(board, player) do
		board 
		|> GameEngine.Board.two_empty_spaces_triples_in_board(player)
		|> find_corners(player)
		|> filter_possible_opponents_forks(board, player)
		|> List.first
	end

	def find_corners(%{rows: rows, columns: columns, diagonals: diagonals}, player) do
		find_corners_in_rows(rows, player) ++ find_corners_in_columns(columns, player) ++ find_corners_in_diagonals(diagonals, player)
		|> Enum.uniq
	end

	def filter_possible_opponents_forks(possible_moves, board, player) do
		possible_moves
		|> Enum.filter(fn(possible_move) -> 
			is_safe_defence?(possible_move, board, player) end)
	end

	def is_safe_defence?(possible_move, board, player) do
		opponent_fork = get_possible_opponent_fork(possible_move, board, player)
		!opponent_defence_is_fork?(opponent_fork, possible_move, board, player)
	end	

	def get_possible_opponent_fork(possible_move, current_board, player) do
		back_to_future_board = GameEngine.Board.put_mark(current_board, possible_move, player)
		GameEngine.PlayStrategies.KickAssForkMoves.find(back_to_future_board, know_your_enemy(player))
	end

	def opponent_defence_is_fork?(nil, _players_move, _current_board, _player), do: false

	def opponent_defence_is_fork?(opponent_fork, players_move, current_board, player) do
		board_with_player_move = GameEngine.Board.put_mark(current_board, players_move, player)
		block_win = GameEngine.PlayStrategies.KickAssWinMoves.win(board_with_player_move, player)

		block_win == opponent_fork
	end


	def know_your_enemy(:o), do: :x

	def know_your_enemy(:x), do: :o

	def find_corners_in_rows([], _player), do: []
	def find_corners_in_rows({[nil, nil, mark], row}, player) when row in [0, 2] and mark == player, do: [%{row: row, column: 0}]
	def find_corners_in_rows({[nil, mark, nil], row}, player) when row in [0, 2] and mark == player, do: [%{row: row, column: 0}, %{row: row, column: 2}]
	def find_corners_in_rows({[mark, nil, nil], row}, player) when row in [0, 2] and mark == player, do: [%{row: row, column: 2}]
	def find_corners_in_rows({[_, _, _], 1}, _player), do: []

	def find_corners_in_rows([triple|tail], player) do
		find_corners_in_rows(triple, player) ++ find_corners_in_rows(tail, player)
	end

	def find_corners_in_columns([], _player), do: []
	def find_corners_in_columns({[nil, nil, mark], column}, player) when column in [0, 2] and mark == player, do: [%{row: 0, column: column}]
	def find_corners_in_columns({[nil, mark, nil], column}, player) when column in [0, 2] and mark == player, do: [%{row: 0, column: column}, %{row: 2, column: column}]
	def find_corners_in_columns({[mark, nil, nil], column}, player) when column in [0, 2] and mark == player, do: [%{row: 2, column: column}]
	def find_corners_in_columns({[_, _, _], 1}, _player), do: []

	def find_corners_in_columns([triple|tail], player) do
		find_corners_in_columns(triple, player) ++ find_corners_in_columns(tail, player)
	end

	def find_corners_in_diagonals([], _player), do: []
	def find_corners_in_diagonals({[nil, nil, mark], 0}, player) when mark == player, do: [%{row: 0, column: 0}]
	def find_corners_in_diagonals({[nil, mark, nil], 0}, player) when mark == player, do: [%{row: 0, column: 0}, %{row: 2, column: 2}]
	def find_corners_in_diagonals({[mark, nil, nil], 0}, player) when mark == player, do: [%{row: 2, column: 2}]

	def find_corners_in_diagonals({[nil, nil, mark], 1}, player) when mark == player, do: [%{row: 0, column: 2}]
	def find_corners_in_diagonals({[nil, mark, nil], 1}, player) when mark == player, do: [%{row: 0, column: 2}, %{row: 2, column: 0}]
	def find_corners_in_diagonals({[mark, nil, nil], 1}, player) when mark == player, do: [%{row: 2, column: 0}]
	def find_corners_in_diagonals({[_, _, _], _}, _player), do: []

	def find_corners_in_diagonals([triple|tail], player) do
		find_corners_in_diagonals(triple, player) ++ find_corners_in_diagonals(tail, player)
	end
end