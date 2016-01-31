defmodule GameEngine.PlayStrategies.KickAssStrategy do

	alias GameEngine.PlayStrategies

	def calculate_move(board, player) do
		
		opponent = spot_opponent(player)

		cond do
			win = PlayStrategies.KickAssWinMoves.win(board, player) ->
				win

			block = PlayStrategies.KickAssWinMoves.win(board, opponent) ->
				block

			fork = PlayStrategies.KickAssForkMoves.fork(board, player) ->
				fork

			block_fork = PlayStrategies.KickAssForkMoves.fork(board, opponent) ->
				block_fork

			force_defending = PlayStrategies.KickAssForceDefendingMoves.force_defending(board, player) ->
				force_defending

			center = PlayStrategies.KickAssAbsoluteLocationMoves.play_center(board) ->
				center

			corner = PlayStrategies.KickAssOpponentsOppositeCornerMoves.find_corner(board, opponent) ->
				corner
		end
	end

	def spot_opponent(:o), do: :x
	def spot_opponent(:x), do: :o

end