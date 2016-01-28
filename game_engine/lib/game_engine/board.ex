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
		positions
		|> Tuple.to_list
		|> Enum.all?(fn(position) -> position_occupied?(position) end)
	end

	def get_by_position(%GameEngine.Board{positions: positions}, %{row: row, column: column}) do
		positions
		|> Tuple.to_list
		|> Enum.at(get_index(row, column))
	end

	def put_mark(%GameEngine.Board{positions: positions}, %{row: row, column: column}, mark) do
		new_positions = positions
		|> put_elem(get_index(row, column), mark)

		%GameEngine.Board{positions: new_positions}
	end

	def available_positions(%GameEngine.Board{positions: positions}) do
		for position <- decompound_positions(positions),
		{mark, index} = position,
		!position_occupied?(mark) do
			row_column(index)
		end
	end

	defp position_occupied?(mark), do: mark != nil

	defp get_index(row, column), do: row * 3 + column

	defp decompound_positions(positions) do
		positions |> Tuple.to_list |> Enum.with_index
	end

	defp row_column(index) do
		%{row: div(index, 3), column: rem(index, 3)}
	end
	
end