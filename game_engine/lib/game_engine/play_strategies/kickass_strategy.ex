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

			prevent_fork = PlayStrategies.KickAssPreventOpponentForkMoves.prevent_fork(board, opponent) ->
				prevent_fork

			block_fork = PlayStrategies.KickAssForkMoves.fork(board, opponent) ->
				block_fork

			force_fork = PlayStrategies.KickAssForceForkMoves.force_fork(board, player) ->
				force_fork

			center = PlayStrategies.KickAssAbsoluteLocationMoves.play_center(board) ->
				center

			opponent_opposite_corner = PlayStrategies.KickAssOpponentsOppositeCornerMoves.find_corner(board, opponent) ->
				opponent_opposite_corner

			empty_corner = PlayStrategies.KickAssAbsoluteLocationMoves.take_empty_corner(board) ->
				empty_corner

			empty_side = PlayStrategies.KickAssAbsoluteLocationMoves.take_empty_side(board) ->
				empty_side
		end
	end

	def spot_opponent(:o), do: :x
	def spot_opponent(:x), do: :o

end