defmodule GameEngine.RandomPositions do
	def get(avaliable_positions), do: Enum.random(avaliable_positions)
end