defmodule GameEngine.PlayStrategies.KickAssStrategy do

	def calculate_move(board, player) do
		
		opponent = spot_opponent(player)

		cond do
			win = GameEngine.PlayStrategies.KickAssWinMoves.win(board, player) ->
				win

			block = GameEngine.PlayStrategies.KickAssWinMoves.win(board, opponent) ->
				block

			fork = GameEngine.PlayStrategies.KickAssForkMoves.fork(board, player) ->
				fork

			block_fork = GameEngine.PlayStrategies.KickAssForkMoves.fork(board, opponent) ->
				block_fork

			force_defending = GameEngine.PlayStrategies.KickAssForceDefendingMoves.force_defending(board, player) ->
				force_defending
		end
	end

	def spot_opponent(:o), do: :x
	def spot_opponent(:x), do: :o

end