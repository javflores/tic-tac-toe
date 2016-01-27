defmodule GameEngine.Board do

	defstruct positions: {nil, nil, nil,
						  nil, nil, nil,
						  nil, nil, nil}

	def resolve_winner(board) do
		{:no_winner}
	end

	def full?(board) do
		false
	end
	
end