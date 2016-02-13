defmodule GameEngine.PlayStrategies.KickAssAttackMoves do
	def find(board, player) do
		board 
		|> GameEngine.Board.two_empty_spaces_triples_in_board(player)
		|> filter_non_duplicated
		|> filter_possible_opponents_forks(board, player)
		|> List.first
	end

	def filter_non_duplicated(triples) do
		%{non_duplicates: non_duplicated_spaces, all: _all_two_empty_spaces} = triples
		|> GameEngine.BoardCutter.triples_with_two_empty_spaces
		non_duplicated_spaces
	end

	def filter_possible_opponents_forks(possible_moves, board, player) do
		possible_moves
		|> Enum.filter(fn(possible_move) -> 
			is_safe_defence?(possible_move, board, player) end)
	end

	def is_safe_defence?(possible_move, board, player) do
		opponent_fork = get_possible_opponent_fork(possible_move, board, player)
		!opponent_defence_is_fork?(opponent_fork, possible_move, board, player)
	end	

	def get_possible_opponent_fork(possible_move, current_board, player) do
		back_to_future_board = GameEngine.Board.put_mark(current_board, possible_move, player)
		GameEngine.PlayStrategies.KickAssForkMoves.find(back_to_future_board, GameEngine.Player.know_your_enemy(player))
	end

	def opponent_defence_is_fork?(nil, _players_move, _current_board, _player), do: false

	def opponent_defence_is_fork?(opponent_fork, players_move, current_board, player) do
		board_with_player_move = GameEngine.Board.put_mark(current_board, players_move, player)
		block_win = GameEngine.PlayStrategies.KickAssWinMoves.win(board_with_player_move, player)

		block_win == opponent_fork
	end
end