defmodule GameEngine.PlayStrategies.Moves.EmptyCorner do

    @behaviour GameEngine.PlayStrategies.Move

    def find(%GameEngine.Board{positions: {nil, _, _,
                                            _, _, _,
                                            _, _, _}}, _player), do: %{row: 0, column: 0}

    def find(%GameEngine.Board{positions: {_, _, nil,
                                            _, _, _,
                                            _, _, _}}, _player), do: %{row: 0, column: 2}

    def find(%GameEngine.Board{positions: {_, _, _,
                                            _, _, _,
                                            nil, _, _}}, _player), do: %{row: 2, column: 0}

    def find(%GameEngine.Board{positions: {_, _, _,
                                            _, _, _,
                                            _, _, nil}}, _player), do: %{row: 2, column: 2}

    def find(%GameEngine.Board{positions: {_, _, _,
                                            _, _, _,
                                            _, _, _}}, _player), do: nil
end
