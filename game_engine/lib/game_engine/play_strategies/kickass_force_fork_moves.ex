defmodule GameEngine.PlayStrategies.KickAssForceForkMoves do
	def find(board, player) do
		GameEngine.PlayStrategies.KickAssAttackOpponentsForkMoves.attack(true, board, player)
		|> move_leading_to_own_fork(board, player)
	end

	def move_leading_to_own_fork(nil, _board, _player), do: nil
	def move_leading_to_own_fork([], _board, _player), do: nil	

	def move_leading_to_own_fork(all_attacks, board, player) when is_list(all_attacks)  do
		Enum.find(all_attacks, 
			fn(attack) -> results_in_later_fork?(attack, board, player) end)
	end

	def move_leading_to_own_fork(attack, board, player) do
		if results_in_later_fork?(attack, board, player) do
			attack
		else
			nil
		end
	end

	def results_in_later_fork?(attack, current_board, player) do
		back_to_future_board = GameEngine.Board.put_mark(current_board, attack, player)

		block_win = GameEngine.PlayStrategies.KickAssWinMoves.win(back_to_future_board, player)
		future_board_with_possible_fork = GameEngine.Board.put_mark(back_to_future_board, block_win, GameEngine.Player.know_your_enemy(player))

		GameEngine.PlayStrategies.KickAssForkMoves.find(future_board_with_possible_fork, player) != nil
	end
end