defmodule GameEngine.PlayStrategies.Moves.RandomPositions do

    @behaviour GameEngine.PlayStrategies.Move

    def find(avaliable_positions), do: Enum.random(avaliable_positions)
end
