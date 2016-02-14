defmodule GameEngine.PlayStrategies.Moves.RandomPositions do
	def find(avaliable_positions), do: Enum.random(avaliable_positions)
end