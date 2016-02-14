defmodule GameEngine.PlayStrategies.OpponentsForksBlocker do
	def reject(possible_moves, board, player) do
		possible_moves
		|> Enum.filter(fn(possible_move) -> 
			is_safe_defence?(possible_move, board, player) end)
	end

	def is_safe_defence?(possible_move, board, player) do
		opponent_defence = get_opponent_defence(possible_move, board, player)
		!opponent_defence_is_fork?(opponent_defence, possible_move, board, player)
	end	

	defp get_opponent_defence(possible_move, current_board, player) do
		back_to_future_board = GameEngine.Board.put_mark(current_board, possible_move, player)
		GameEngine.PlayStrategies.KickAssWinMoves.find(back_to_future_board, player)
	end

	defp opponent_defence_is_fork?(nil, _players_move, _current_board, _player), do: false

	defp opponent_defence_is_fork?(opponent_defence, players_move, current_board, player) do		
		opponent = GameEngine.Player.know_your_enemy(player)
		board_with_player_move = GameEngine.Board.put_mark(current_board, players_move, player)
		
		GameEngine.PlayStrategies.KickAssForkMoves.find_all(board_with_player_move, opponent)
		|> Enum.any?(fn fork -> fork == opponent_defence end)
	end
end