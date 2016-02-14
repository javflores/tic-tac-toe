defmodule GameEngine.PlayStrategies.Moves.AttackOpponentsFork do
	def find(board, player) do
		board
		|> find_all(player)
		|> first
	end

	def find_all(board, player) do
		board
		|> opponent_has_forks?(player)
		|> attack(board, player)
	end

	def opponent_has_forks?(board, player) do
		opponent_forks = board
		|> GameEngine.PlayStrategies.Moves.Fork.find_all(GameEngine.Player.know_your_enemy(player))
		
		opponent_forks != []
	end

	def attack(false, _board, _player), do: nil

	def attack(true, board, player) do
		board 
		|> GameEngine.Board.two_empty_spaces_triples_in_board(player)
		|> all_possible_atacks
		|> GameEngine.PlayStrategies.Moves.OpponentsForksBlocker.reject(board, player)
	end

	def all_possible_atacks(triples) do
		%{all: all_two_empty_spaces, non_duplicates: _non_duplicated_spaces} = triples
		|> GameEngine.BoardCutter.triples_with_two_empty_spaces
		all_two_empty_spaces
		|> Enum.uniq
	end

	defp first(nil), do: nil
	defp first([]), do: nil

	defp first(all_attacks) do
		List.first(all_attacks)
	end
end