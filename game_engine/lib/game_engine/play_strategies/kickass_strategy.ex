defmodule GameEngine.PlayStrategies.KickAssStrategy do

	alias GameEngine.PlayStrategies

	def calculate_move(board, player) do
		
		opponent = know_your_enemy(player)

		cond do
			win = PlayStrategies.KickAssWinMoves.win(board, player) ->
				win

			block = PlayStrategies.KickAssWinMoves.win(board, opponent) ->
				block

			fork = PlayStrategies.KickAssForkMoves.find(board, player) ->
				fork			

			attack = PlayStrategies.KickAssAttackMoves.find(board, opponent) ->
				attack

			block_fork = PlayStrategies.KickAssForkMoves.find(board, opponent) ->
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

	def know_your_enemy(:o), do: :x
	def know_your_enemy(:x), do: :o

end