defmodule GameEngine.PlayStrategies.Moves.Fork do
	def find(board, player) do
		board 
		|> find_all(player)
		|> List.first
	end

	def find_all(board, player) do		
		board 
		|> GameEngine.Board.two_empty_spaces_triples_in_board(player)
		|> GameEngine.BoardCutter.triples_with_two_empty_spaces
		|> duplicated_empty_spaces
	end	

	defp duplicated_empty_spaces(%{all: all_two_empty_spaces, non_duplicates: non_duplicated_spaces}) do
		all_two_empty_spaces -- non_duplicated_spaces
	end
end