defmodule GameEngine.PlayStrategies.KickAssStrategy do

	alias GameEngine.PlayStrategies

	def calculate_move(board, player) do
		
		opponent = GameEngine.Player.know_your_enemy(player)

		cond do
			win = PlayStrategies.KickAssWinMoves.find(board, player) ->
				win

			block = PlayStrategies.KickAssWinMoves.find(board, opponent) ->
				block

			fork = PlayStrategies.KickAssForkMoves.find(board, player) ->
				fork

			attack_fork = PlayStrategies.KickAssAttackOpponentsForkMoves.find(board, player) ->
				attack_fork

			block_fork = PlayStrategies.KickAssForkMoves.find(board, opponent) ->
				block_fork

			force_fork = PlayStrategies.KickAssForceForkMoves.find(board, player) ->
				force_fork

			center = PlayStrategies.KickAssPlayCenterMoves.find(board) ->
				center

			opponent_opposite_corner = PlayStrategies.KickAssOpponentsOppositeCornerMoves.find(board, opponent) ->
				opponent_opposite_corner

			empty_corner = PlayStrategies.KickAssEmptyCornerMoves.find(board) ->
				empty_corner

			empty_side = PlayStrategies.KickAssEmptySideMoves.find(board) ->
				empty_side
		end
	end
end