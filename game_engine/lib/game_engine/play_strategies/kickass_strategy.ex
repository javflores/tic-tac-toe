defmodule GameEngine.PlayStrategies.KickAssStrategy do

	def calculate_move(board, player) do
		
		oponent = spot_opponent(player)

		cond do
			win = GameEngine.PlayStrategies.KickAssWinMoves.win(board, player) ->
				win

			block = GameEngine.PlayStrategies.KickAssWinMoves.win(board, oponent) ->
				block
		end
	end

	def spot_opponent(:o), do: :x
	def spot_opponent(:x), do: :o
	
end