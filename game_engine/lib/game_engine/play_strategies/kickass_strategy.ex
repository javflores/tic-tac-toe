defmodule GameEngine.PlayStrategies.KickAssStrategy do

	alias GameEngine.PlayStrategies.Moves

	def calculate_move(board, player) do		
		cond do
			win = Moves.Win.find(board, player) ->
				win

			block = Moves.BlockWin.find(board, player) ->
				block

			fork = Moves.Fork.find(board, player) ->
				fork

			attack_fork = Moves.AttackOpponentsFork.find(board, player) ->
				attack_fork

			block_fork = Moves.BlockFork.find(board, player) ->
				block_fork

			force_fork = Moves.ForceFork.find(board, player) ->
				force_fork

			center = Moves.Center.find(board, player) ->
				center

			opponent_opposite_corner = Moves.OpponentsOppositeCorner.find(board, player) ->
				opponent_opposite_corner

			empty_corner = Moves.EmptyCorner.find(board, player) ->
				empty_corner

			empty_side = Moves.EmptySide.find(board, player) ->
				empty_side
		end
	end
end