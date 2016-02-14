defmodule GameEngine.PlayStrategies.Moves.EmptySide do

	def find(%GameEngine.Board{positions: {_, nil, _,
						 					_, _, _,
						 					_, _, _}}), do: %{row: 0, column: 1}

	def find(%GameEngine.Board{positions: {_, _, _,
						 					nil, _, _,
						 					_, _, _}}), do: %{row: 1, column: 0}

	def find(%GameEngine.Board{positions: {_, _, _,
						 					_, _, nil,
						 					_, _, _}}), do: %{row: 1, column: 2}

	def find(%GameEngine.Board{positions: {_, _, _,
						 					_, _, _,
						 					_, nil, _}}), do: %{row: 2, column: 1}
end