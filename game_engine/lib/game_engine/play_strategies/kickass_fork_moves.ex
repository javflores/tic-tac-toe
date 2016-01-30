defmodule GameEngine.PlayStrategies.KickAssForkMoves do
	def fork(board, player) do
		board 
		|> two_empty_spaces_triples_in_board(player)
		|> duplicated_empty_spaces
		|> List.first
	end

	def two_empty_spaces_triples_in_board(%GameEngine.Board{positions: positions}, player) do
		%{rows: rows, columns: columns, diagonals: diagonals} = GameEngine.Board.find_triples(%GameEngine.Board{positions: positions})
		%{rows: two_empty_spaces(rows, player), columns: two_empty_spaces(columns, player), diagonals: two_empty_spaces(diagonals, player)}
	end

	def two_empty_spaces(triples, player) do
		triples
		|> Enum.with_index
		|> Enum.filter(&two_empty_spaces?(&1, player))
	end

	def two_empty_spaces?({[mark, nil, nil], _}, player), do: mark == player
	def two_empty_spaces?({[nil, mark, nil], _}, player), do: mark == player
	def two_empty_spaces?({[nil, nil, mark], _}, player), do: mark == player
	def two_empty_spaces?({[_, _, _], _}, _), do: false

	defp duplicated_empty_spaces(%{rows: rows, columns: columns, diagonals: diagonals}) do
		all_empty_spaces = empty_spaces_in_rows(rows) ++ empty_spaces_in_columns(columns) ++ empty_spaces_in_diagonals(diagonals)
		
		non_duplicated_spaces = all_empty_spaces
		|> Enum.uniq

		all_empty_spaces -- non_duplicated_spaces
	end

	def empty_spaces_in_rows([]), do: []

	def empty_spaces_in_rows({[nil, nil, _], row_number}), do: [%{row: row_number, column: 0}, %{row: row_number, column: 1}]
	def empty_spaces_in_rows({[nil, _, nil], row_number}), do: [%{row: row_number, column: 0}, %{row: row_number, column: 2}]
	def empty_spaces_in_rows({[_, nil, nil], row_number}), do: [%{row: row_number, column: 1}, %{row: row_number, column: 2}]

	def empty_spaces_in_rows([triple|tail]) do
		empty_spaces_in_rows(triple) ++ empty_spaces_in_rows(tail)
	end

	def empty_spaces_in_columns([]), do: []

	def empty_spaces_in_columns({[nil, nil, _], column_number}), do: [%{row: 0, column: column_number}, %{row: 1, column: column_number}]
	def empty_spaces_in_columns({[nil, _, nil], column_number}), do: [%{row: 0, column: column_number}, %{row: 2, column: column_number}]
	def empty_spaces_in_columns({[_, nil, nil], column_number}), do: [%{row: 1, column: column_number}, %{row: 2, column: column_number}]

	def empty_spaces_in_columns([triple|tail]) do
		empty_spaces_in_columns(triple) ++ empty_spaces_in_columns(tail)
	end

	def empty_spaces_in_diagonals([]), do: []

	def empty_spaces_in_diagonals({[nil, nil, _], diagonal_number}) do
		case diagonal_number do
			0 ->
				[%{row: 0, column: 0}, %{row: 1, column: 1}]
			1 ->
				[%{row: 0, column: 2}, %{row: 1, column: 1}]
		end		
	end
	
	def empty_spaces_in_diagonals({[nil, _, nil], diagonal_number}) do
		case diagonal_number do
			0 ->
				[%{row: 0, column: 0}, %{row: 2, column: 2}]
			1 ->
				[%{row: 0, column: 2}, %{row: 2, column: 0}]
		end		
	end

	def empty_spaces_in_diagonals({[_, nil, nil], diagonal_number}) do
		case diagonal_number do
			0 ->
				[%{row: 1, column: 1}, %{row: 2, column: 2}]
			1 ->
				[%{row: 1, column: 1}, %{row: 2, column: 0}]
		end		
	end	

	def empty_spaces_in_diagonals([triple|tail]) do
		empty_spaces_in_diagonals(triple) ++ empty_spaces_in_diagonals(tail)
	end
end