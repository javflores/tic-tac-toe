defmodule GameEngine.Board do

	@players [:o, :x]

	defstruct positions: {nil, nil, nil,
						  nil, nil, nil,
						  nil, nil, nil}

	def resolve_winner(%GameEngine.Board{positions: {player, player, player, 
													  _, _, _, 
													  _, _, _}}) when player in @players, do: {:winner, player}

	def resolve_winner(%GameEngine.Board{positions: {_, _, _,
													 player, player, player, 
													 _, _, _}}) when player in @players, do: {:winner, player}

	def resolve_winner(%GameEngine.Board{positions: {_, _, _,
													 _, _, _, 
													 player, player, player}}) when player in @players, do: {:winner, player}

	def resolve_winner(%GameEngine.Board{positions: {player, _, _,
													 player, _, _, 
													 player, _, _}}) when player in @players, do: {:winner, player}

	def resolve_winner(%GameEngine.Board{positions: {_, player, _,
													 _, player, _, 
													 _, player, _}}) when player in @players, do: {:winner, player}

	def resolve_winner(%GameEngine.Board{positions: {_, _, player,
													 _, _, player,
													 _, _, player}}) when player in @players, do: {:winner, player}

	def resolve_winner(%GameEngine.Board{positions: {_, _, player,
													 _, player, _,
													 player, _, _}}) when player in @players, do: {:winner, player}

	def resolve_winner(%GameEngine.Board{positions: {player, _, _,
													 _, player, _,
													 _, _, player}}) when player in @players, do: {:winner, player}

	def resolve_winner(%GameEngine.Board{positions: positions}) do
		{:no_winner}
	end

	def full?(%GameEngine.Board{positions: positions}) do
		Tuple.to_list(positions)
		|> Enum.all?(fn(position) -> position_occupied?(position) end)
	end

	defp position_occupied?(position), do: position != nil
	
end