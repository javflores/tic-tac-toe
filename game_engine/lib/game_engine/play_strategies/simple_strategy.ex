defmodule GameEngine.PlayStrategies.SimpleStrategy do
	def calculate_move(board) do

		GameEngine.Board.available_positions(board)
		|> GameEngine.PlayStrategies.RandomPositions.get
	end
end