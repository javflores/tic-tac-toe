defmodule GameEngine.PlayStrategies.KickAssStrategy do
	def calculate_move(board, player) do
 		GameEngine.PlayStrategies.KickAssMoves.all()
		|> Enum.reduce_while(:not_found, 
			fn move, _acc -> try_move(move, board, player) end)
	end

	defp try_move(move, board, player) do
		move.find(board, player)
		|> check
	end

	defp check(nil), do: {:cont, :not_found}
	defp check(position) when is_map(position), do: {:halt, position}
end