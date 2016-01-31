defmodule GameEngine.PlayStrategies.KickAssAbsoluteLocationMoves do

	def play_center(%GameEngine.Board{positions: {_, _, _,
						 					  	  _, nil, _,
						 					  	  _, _, _}}), do: %{row: 1, column: 1}

	def play_center(%GameEngine.Board{positions: {_, _, _,
						 					  	  _, center, _,
						 					  	  _, _, _}}) when center != nil, do: nil

	def take_empty_corner(%GameEngine.Board{positions: {nil, _, _,
						 					  	  		_, _, _,
						 					  	  		_, _, _}}), do: %{row: 0, column: 0}

	def take_empty_corner(%GameEngine.Board{positions: {_, _, nil,
						 					  	  		_, _, _,
						 					  	  		_, _, _}}), do: %{row: 0, column: 2}

	def take_empty_corner(%GameEngine.Board{positions: {_, _, _,
						 					  	  		_, _, _,
						 					  	  		nil, _, _}}), do: %{row: 2, column: 0}

	def take_empty_corner(%GameEngine.Board{positions: {_, _, _,
						 					  	  		_, _, _,
						 					  	  		_, _, nil}}), do: %{row: 2, column: 2}
end