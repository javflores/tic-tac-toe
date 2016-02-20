defmodule GameEngine.PlayStrategies.Moves.OpponentsOppositeCorner do

    @behaviour GameEngine.PlayStrategies.Move

    def find({mark, _, _,
              _, _, _,
              _, _, nil}, player) when mark != player and mark != nil, do: %{row: 2, column: 2}

    def find({_, _, mark,
              _, _, _,
              nil, _, _}, player) when mark != player and mark != nil, do: %{row: 2, column: 0}

    def find({_, _, nil,
              _, _, _,
              mark, _, _}, player) when mark != player and mark != nil, do: %{row: 0, column: 2}

    def find({nil, _, _,
              _, _, _,
              _, _, mark}, player) when mark != player and mark != nil, do: %{row: 0, column: 0}

    def find({_, _, _,
              _, _, _,
              _, _, _}, _player), do: nil
end
