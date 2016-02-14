defmodule GameEngine.PlayStrategies.KickAssStrategy do

	alias GameEngine.PlayStrategies

	def calculate_move(board, player) do
		
		opponent = GameEngine.Player.know_your_enemy(player)

		cond do
			win = PlayStrategies.KickAssWinMoves.win(board, player) ->
				win

			block = PlayStrategies.KickAssWinMoves.win(board, opponent) ->
				block

			fork = PlayStrategies.KickAssForkMoves.find(board, player) ->
				fork

			attack_fork = PlayStrategies.KickAssAttackOpponentsForkMoves.find(board, player) ->
				attack_fork

			block_fork = PlayStrategies.KickAssForkMoves.find(board, opponent) ->
				block_fork

			force_fork = PlayStrategies.KickAssForceForkMoves.find(board, player) ->
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
end