defmodule GameEngine.PlayStrategies.KickAssStrategy do

	alias GameEngine.PlayStrategies.Moves

	def calculate_move(board, player) do
		
		opponent = GameEngine.Player.know_your_enemy(player)

		cond do
			win = Moves.Win.find(board, player) ->
				win

			block = Moves.Win.find(board, opponent) ->
				block

			fork = Moves.Fork.find(board, player) ->
				fork

			attack_fork = Moves.AttackOpponentsFork.find(board, player) ->
				attack_fork

			block_fork = Moves.Fork.find(board, opponent) ->
				block_fork

			force_fork = Moves.ForceFork.find(board, player) ->
				force_fork

			center = Moves.Center.find(board) ->
				center

			opponent_opposite_corner = Moves.OpponentsOppositeCorner.find(board, opponent) ->
				opponent_opposite_corner

			empty_corner = Moves.EmptyCorner.find(board) ->
				empty_corner

			empty_side = Moves.EmptySide.find(board) ->
				empty_side
		end
	end
end