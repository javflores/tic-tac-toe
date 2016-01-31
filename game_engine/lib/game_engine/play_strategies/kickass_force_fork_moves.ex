defmodule GameEngine.PlayStrategies.KickAssForceForkMoves do
	def force_fork(board, player) do
		board 
		|> GameEngine.Board.two_empty_spaces_triples_in_board(player)
		|> find_corners
		|> filter_moves_not_leading_to_fork(board, player)
		|> filter_possible_opponents_forks(board, player)
		|> List.first
	end

	def find_corners(%{rows: rows, columns: columns, diagonals: diagonals}) do
		find_corners_in_rows(rows) ++ find_corners_in_columns(columns) ++ find_corners_in_diagonals(diagonals)
		|> Enum.uniq
	end

	def find_corners_in_rows([]), do: []
	def find_corners_in_rows({[nil, nil, :o], row}) when row in [0, 2], do: [%{row: row, column: 0}]
	def find_corners_in_rows({[nil, :o, nil], row}) when row in [0, 2], do: [%{row: row, column: 0}, %{row: row, column: 2}]
	def find_corners_in_rows({[:o, nil, nil], row}) when row in [0, 2], do: [%{row: row, column: 2}]
	def find_corners_in_rows({[_, _, _], 1}), do: []

	def find_corners_in_rows([triple|tail]) do
		find_corners_in_rows(triple) ++ find_corners_in_rows(tail)
	end

	def find_corners_in_columns([]), do: []
	def find_corners_in_columns({[nil, nil, :o], column}) when column in [0, 2], do: [%{row: 0, column: column}]
	def find_corners_in_columns({[nil, :o, nil], column}) when column in [0, 2], do: [%{row: 0, column: column}, %{row: 2, column: column}]
	def find_corners_in_columns({[:o, nil, nil], column}) when column in [0, 2], do: [%{row: 2, column: column}]
	def find_corners_in_columns({[_, _, _], 1}), do: []

	def find_corners_in_columns([triple|tail]) do
		find_corners_in_columns(triple) ++ find_corners_in_columns(tail)
	end

	def find_corners_in_diagonals([]), do: []
	def find_corners_in_diagonals({[nil, nil, :o], 0}), do: [%{row: 0, column: 0}]
	def find_corners_in_diagonals({[nil, :o, nil], 0}), do: [%{row: 0, column: 0}, %{row: 2, column: 2}]
	def find_corners_in_diagonals({[:o, nil, nil], 0}), do: [%{row: 2, column: 2}]

	def find_corners_in_diagonals({[nil, nil, :o], 1}), do: [%{row: 0, column: 2}]
	def find_corners_in_diagonals({[nil, :o, nil], 1}), do: [%{row: 0, column: 2}, %{row: 2, column: 0}]
	def find_corners_in_diagonals({[:o, nil, nil], 1}), do: [%{row: 2, column: 0}]
	def find_corners_in_diagonals({[_, _, _], _}), do: []

	def find_corners_in_diagonals([triple|tail]) do
		find_corners_in_diagonals(triple) ++ find_corners_in_diagonals(tail)
	end

	def filter_possible_opponents_forks(possible_moves, board, player) do
		possible_moves
		|> Enum.filter(fn(possible_move) -> !results_in_opponents_fork?(possible_move, board, player) end)
	end

	def results_in_opponents_fork?(possible_move, current_board, player) do
		back_to_future_board = GameEngine.Board.put_mark(current_board, possible_move, player)
		GameEngine.PlayStrategies.KickAssForkMoves.fork(back_to_future_board, know_your_enemy(player)) != nil
	end

	def filter_moves_not_leading_to_fork(possible_moves, current_board, player) do
		possible_moves
		|> Enum.filter(fn(possible_move) -> results_in_later_fork?(possible_move, current_board, player) end)
	end

	def results_in_later_fork?(possible_move, current_board, player) do
		back_to_future_board = GameEngine.Board.put_mark(current_board, possible_move, player)
		block_win = GameEngine.PlayStrategies.KickAssWinMoves.win(back_to_future_board, player)

		future_board_with_possible_fork = GameEngine.Board.put_mark(back_to_future_board, block_win, know_your_enemy(player))

		GameEngine.PlayStrategies.KickAssForkMoves.fork(future_board_with_possible_fork, player) != nil
	end


	def know_your_enemy(:o), do: :x

	def know_your_enemy(:x), do: :o
end