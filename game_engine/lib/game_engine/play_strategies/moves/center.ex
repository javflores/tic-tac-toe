defmodule GameEngine.PlayStrategies.Moves.Center do

    @behaviour GameEngine.PlayStrategies.Move

    def find(%GameEngine.Board{positions: {_, _, _,
                                           _, nil, _,
                                           _, _, _}}, _player), do: %{row: 1, column: 1}

    def find(%GameEngine.Board{positions: {_, _, _,
                                           _, center, _,
                                           _, _, _}}, _player) when center != nil, do: nil
end
