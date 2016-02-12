defmodule GameEngine.PlayStrategies.KickAssForceForkMoves do
	def force_fork(board, player) do
		board 
		|> GameEngine.PlayStrategies.KickAssPreventOpponentForkMoves.prevent_fork(player)
		|> filter_moves_not_leading_to_fork(board, player)
	end

	def filter_moves_not_leading_to_fork(prevent_opponent_fork_move, current_board, player) do		
		if results_in_later_fork?(prevent_opponent_fork_move, current_board, player) do
			prevent_opponent_fork_move
		else
			nil			
		end
	end

	def results_in_later_fork?(nil, _current_board, _player), do: false

	def results_in_later_fork?(prevent_opponent_fork_move, current_board, player) do
		back_to_future_board = GameEngine.Board.put_mark(current_board, prevent_opponent_fork_move, player)

		block_win = GameEngine.PlayStrategies.KickAssWinMoves.win(back_to_future_board, player)
		future_board_with_possible_fork = GameEngine.Board.put_mark(back_to_future_board, block_win, know_your_enemy(player))

		GameEngine.PlayStrategies.KickAssForkMoves.fork(future_board_with_possible_fork, player) != nil
	end


	def know_your_enemy(:o), do: :x

	def know_your_enemy(:x), do: :o
end