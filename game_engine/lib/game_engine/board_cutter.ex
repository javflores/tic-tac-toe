defmodule GameEngine.BoardCutter do
	def triples_with_two_empty_spaces(%{rows: rows, columns: columns, diagonals: diagonals}) do
		all_two_empty_spaces = two_empty_spaces_in_rows(rows) 
								++ two_empty_spaces_in_columns(columns) 
								++ two_empty_spaces_in_diagonals(diagonals)
		
		non_duplicated_spaces = all_two_empty_spaces
		|> Enum.uniq

		%{all: all_two_empty_spaces, non_duplicates: non_duplicated_spaces}
	end

	def two_empty_spaces_in_rows([]), do: []

	def two_empty_spaces_in_rows({[nil, nil, _], row_number}), do: [%{row: row_number, column: 0}, %{row: row_number, column: 1}]
	def two_empty_spaces_in_rows({[nil, _, nil], row_number}), do: [%{row: row_number, column: 0}, %{row: row_number, column: 2}]
	def two_empty_spaces_in_rows({[_, nil, nil], row_number}), do: [%{row: row_number, column: 1}, %{row: row_number, column: 2}]

	def two_empty_spaces_in_rows([triple|tail]) do
		two_empty_spaces_in_rows(triple) ++ two_empty_spaces_in_rows(tail)
	end

	def two_empty_spaces_in_columns([]), do: []

	def two_empty_spaces_in_columns({[nil, nil, _], column_number}), do: [%{row: 0, column: column_number}, %{row: 1, column: column_number}]
	def two_empty_spaces_in_columns({[nil, _, nil], column_number}), do: [%{row: 0, column: column_number}, %{row: 2, column: column_number}]
	def two_empty_spaces_in_columns({[_, nil, nil], column_number}), do: [%{row: 1, column: column_number}, %{row: 2, column: column_number}]

	def two_empty_spaces_in_columns([triple|tail]) do
		two_empty_spaces_in_columns(triple) ++ two_empty_spaces_in_columns(tail)
	end

	def two_empty_spaces_in_diagonals([]), do: []

	def two_empty_spaces_in_diagonals({[nil, nil, _], diagonal_number}) do
		case diagonal_number do
			0 ->
				[%{row: 0, column: 0}, %{row: 1, column: 1}]
			1 ->
				[%{row: 0, column: 2}, %{row: 1, column: 1}]
		end		
	end
	
	def two_empty_spaces_in_diagonals({[nil, _, nil], diagonal_number}) do
		case diagonal_number do
			0 ->
				[%{row: 0, column: 0}, %{row: 2, column: 2}]
			1 ->
				[%{row: 0, column: 2}, %{row: 2, column: 0}]
		end		
	end

	def two_empty_spaces_in_diagonals({[_, nil, nil], diagonal_number}) do
		case diagonal_number do
			0 ->
				[%{row: 1, column: 1}, %{row: 2, column: 2}]
			1 ->
				[%{row: 1, column: 1}, %{row: 2, column: 0}]
		end		
	end

	def two_empty_spaces_in_diagonals([triple|tail]) do
		two_empty_spaces_in_diagonals(triple) ++ two_empty_spaces_in_diagonals(tail)
	end
end