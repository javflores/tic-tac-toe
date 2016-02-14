defmodule GameEngine.PlayStrategies.KickAssEmptyCornerMoves do

	def find(%GameEngine.Board{positions: {nil, _, _,
						 					_, _, _,
						 					_, _, _}}), do: %{row: 0, column: 0}

	def find(%GameEngine.Board{positions: {_, _, nil,
						 					_, _, _,
						 					_, _, _}}), do: %{row: 0, column: 2}

	def find(%GameEngine.Board{positions: {_, _, _,
						 					_, _, _,
						 					nil, _, _}}), do: %{row: 2, column: 0}

	def find(%GameEngine.Board{positions: {_, _, _,
						 					_, _, _,
						 					_, _, nil}}), do: %{row: 2, column: 2}

	def find(%GameEngine.Board{positions: {_, _, _,
						 					_, _, _,
						 					_, _, _}}), do: nil
end