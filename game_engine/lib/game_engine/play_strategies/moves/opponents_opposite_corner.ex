defmodule GameEngine.PlayStrategies.Moves.OpponentsOppositeCorner do

    @behaviour GameEngine.PlayStrategies.Move

    def find(%GameEngine.Board{positions: {mark, _, _,
                                            _, _, _,
                                            _, _, nil}}, player)
        when mark != player and mark != nil,
        do: %{row: 2, column: 2}

    def find(%GameEngine.Board{positions: {_, _, mark,
                                            _, _, _,
                                            nil, _, _}}, player)
        when mark != player and mark != nil,
        do: %{row: 2, column: 0}

    def find(%GameEngine.Board{positions: {_, _, nil,
                                            _, _, _,
                                            mark, _, _}}, player)
        when mark != player and mark != nil,
        do: %{row: 0, column: 2}

    def find(%GameEngine.Board{positions: {nil, _, _,
                                            _, _, _,
                                            _, _, mark}}, player)
        when mark != player and mark != nil,
        do: %{row: 0, column: 0}

    def find(%GameEngine.Board{positions: {_, _, _,
                                            _, _, _,
                                            _, _, _}}, _player), do: nil
end
