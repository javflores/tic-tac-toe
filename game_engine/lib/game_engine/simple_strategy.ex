defmodule GameEngine.SimpleStrategy do
	def calculate_move(board) do

		GameEngine.Board.available_positions(board)
		
		%{row: 0, column: 0}
	end
end