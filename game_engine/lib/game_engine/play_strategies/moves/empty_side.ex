defmodule GameEngine.PlayStrategies.Moves.EmptySide do

    @behaviour GameEngine.PlayStrategies.Move

    def find({_, nil, _,
              _, _, _,
              _, _, _}, _player), do: %{row: 0, column: 1}

    def find({_, _, _,
              nil, _, _,
              _, _, _}, _player), do: %{row: 1, column: 0}

    def find({_, _, _,
             _, _, nil,
             _, _, _}, _player), do: %{row: 1, column: 2}

    def find({_, _, _,
              _, _, _,
              _, nil, _}, _player), do: %{row: 2, column: 1}

    def find({_, _, _,
              _, _, _,
              _, _, _}, _player), do: nil
end
