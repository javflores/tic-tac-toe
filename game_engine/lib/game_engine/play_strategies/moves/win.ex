defmodule GameEngine.PlayStrategies.Moves.Win do

	def find(%GameEngine.Board{positions: positions}, player) do
		rows = GameEngine.Board.get_rows(%GameEngine.Board{positions: positions})
		columns = GameEngine.Board.get_columns(%GameEngine.Board{positions: positions})

		cond do
			horizontal_win = horizontal_win(rows, player) -> 
				horizontal_win

			vertical_win = vertical_win(columns, player) -> 
				vertical_win

			diagonal_win = diagonal_win(positions, player) ->
				diagonal_win

			true ->
				nil
		end
	end

	defp horizontal_win([], _player), do: nil

	defp horizontal_win([[nil, mark, mark]], player) when player == mark, do: %{row: 2, column: 0}
	defp horizontal_win([[mark, nil, mark]], player) when player == mark, do: %{row: 2, column: 1}
	defp horizontal_win([[mark, mark, nil]], player) when player == mark, do: %{row: 2, column: 2}

	defp horizontal_win([[nil, mark, mark], [_, _, _]], player) when player == mark, do: %{row: 1, column: 0}
	defp horizontal_win([[mark, nil, mark], [_, _, _]], player) when player == mark, do: %{row: 1, column: 1}
	defp horizontal_win([[mark, mark, nil], [_, _, _]], player) when player == mark, do: %{row: 1, column: 2}

	defp horizontal_win([[nil, mark, mark]|_tail], player) when player == mark, do: %{row: 0, column: 0}
	defp horizontal_win([[mark, nil, mark]|_tail], player) when player == mark, do: %{row: 0, column: 1}
	defp horizontal_win([[mark, mark, nil]|_tail], player) when player == mark, do: %{row: 0, column: 2}

	defp horizontal_win([[_, _, _]|tail], player) , do: horizontal_win(tail, player)


	defp vertical_win([], _player), do: nil

	defp vertical_win([[nil, mark, mark]], player) when player == mark, do: %{row: 0, column: 2}
	defp vertical_win([[mark, nil, mark]], player) when player == mark, do: %{row: 1, column: 2}
	defp vertical_win([[mark, mark, nil]], player) when player == mark, do: %{row: 2, column: 2}

	defp vertical_win([[nil, mark, mark], [_, _, _]], player) when player == mark, do: %{row: 0, column: 1}
	defp vertical_win([[mark, nil, mark], [_, _, _]], player) when player == mark, do: %{row: 1, column: 1}
	defp vertical_win([[mark, mark, nil], [_, _, _]], player) when player == mark, do: %{row: 2, column: 1}

	defp vertical_win([[nil, mark, mark]|_tail], player) when player == mark, do: %{row: 0, column: 0}
	defp vertical_win([[mark, nil, mark]|_tail], player) when player == mark, do: %{row: 1, column: 0}
	defp vertical_win([[mark, mark, nil]|_tail], player) when player == mark, do: %{row: 2, column: 0}

	defp vertical_win([[_, _, _]|tail], player) , do: vertical_win(tail, player)


	defp diagonal_win({nil, _, _, 
					  _, mark, _, 
					  _, _, mark}, player) when player == mark, do: %{row: 0, column: 0}

	defp diagonal_win({mark, _, _, 
					  _, nil, _, 
					  _, _, mark}, player) when player == mark, do: %{row: 1, column: 1}

	defp diagonal_win({mark, _, _,
					  _, mark, _, 
					  _, _, nil}, player) when player == mark, do: %{row: 2, column: 2}

	defp diagonal_win({_, _, nil, 
					  _, mark, _, 
					  mark, _, _}, player) when player == mark, do: %{row: 0, column: 2}

	defp diagonal_win({_, _, mark, 
					  _, nil, _, 
					  mark, _, _}, player) when player == mark, do: %{row: 1, column: 1}

	defp diagonal_win({_, _, mark, 
					  _, mark, _, 
					  nil, _, _}, player) when player == mark, do: %{row: 2, column: 0}

	defp diagonal_win({_, _, _, 
					  _, _, _, 
					  _, _, _}, _player), do: nil
end