defmodule GameEngine.PlayStrategies.KickAssStrategy do

	def calculate_move(board, player) do
		
		oponent = spot_opponent(player)

		cond do
			win = GameEngine.PlayStrategies.KickAssWinMoves.win(board, player) ->
				win

			block = GameEngine.PlayStrategies.KickAssWinMoves.win(board, oponent) ->
				block

			fork = GameEngine.PlayStrategies.KickAssForkMoves.fork(board, player) ->
				fork

			block_fork = GameEngine.PlayStrategies.KickAssForkMoves.fork(board, oponent) ->
				block_fork

			force_defending = GameEngine.PlayStrategies.KickAssForceDefendingMoves.force_defending(board, player) ->
				force_defending
		end
	end

	def spot_opponent(:o), do: :x
	def spot_opponent(:x), do: :o

end