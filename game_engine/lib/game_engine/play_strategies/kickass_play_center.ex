defmodule GameEngine.PlayStrategies.KickAssPlayCenterMoves do

	def find(%GameEngine.Board{positions: {_, _, _,
						 				   _, nil, _,
						 				   _, _, _}}), do: %{row: 1, column: 1}

	def find(%GameEngine.Board{positions: {_, _, _,
						 				   _, center, _,
						 				   _, _, _}}) when center != nil, do: nil
end