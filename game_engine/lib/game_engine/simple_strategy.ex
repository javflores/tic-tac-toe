defmodule GameEngine.SimpleStrategy do
	def calculate_move(board) do

		GameEngine.Board.available_positions(board)
		|> GameEngine.RandomPositions.get
	end
end