defmodule GameEngine.PlayStrategies.KickAssOpponentsOppositeCornerMoves do

	def find_corner(%GameEngine.Board{positions: {mark, _, _,
						 					  	  _, _, _,
						 					  	  _, _, nil}}, opponent) when mark == opponent, do: %{row: 2, column: 2}

	def find_corner(%GameEngine.Board{positions: {_, _, mark,
						 					  	  _, _, _,
						 					  	  nil, _, _}}, opponent) when mark == opponent, do: %{row: 2, column: 0}

	def find_corner(%GameEngine.Board{positions: {_, _, nil,
						 					  	  _, _, _,
						 					  	  mark, _, _}}, opponent) when mark == opponent, do: %{row: 0, column: 2}

	def find_corner(%GameEngine.Board{positions: {nil, _, _,
						 					  	  _, _, _,
						 					  	  _, _, mark}}, opponent) when mark == opponent, do: %{row: 0, column: 0}

	def find_corner(%GameEngine.Board{positions: {_, _, _,
						 					  	  _, _, _,
						 					  	  _, _, _}}, _opponent), do: nil
end