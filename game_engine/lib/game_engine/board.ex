defmodule GameEngine.Board do

    @players [:o, :x]
    @dimension 3

    def get_empty(), do: for position <- 1..@dimension*@dimension, do: nil

    def resolve_winner({player, player, player,
                        _, _, _,
                        _, _, _}) when player in @players, do: :winner

    def resolve_winner({_, _, _,
                       player, player, player,
                       _, _, _}) when player in @players, do: :winner

    def resolve_winner({_, _, _,
                        _, _, _,
                        player, player, player}) when player in @players, do: :winner

    def resolve_winner({player, _, _,
                        player, _, _,
                        player, _, _}) when player in @players, do: :winner

    def resolve_winner({_, player, _,
                        _, player, _,
                        _, player, _}) when player in @players, do: :winner

    def resolve_winner({_, _, player,
                        _, _, player,
                        _, _, player}) when player in @players, do: :winner

    def resolve_winner({_, _, player,
                        _, player, _,
                        player, _, _}) when player in @players, do: :winner

    def resolve_winner({player, _, _,
                        _, player, _,
                        _, _, player}) when player in @players, do: :winner

    def resolve_winner(board) do
        cond do
            full?(board) ->
                :draw
            true ->
                :no_result
        end
    end

    def full?(board) do
        board
        |> Tuple.to_list
        |> Enum.all?(fn(position) -> position_occupied?(position) end)
    end

    def get_by_position(positions, %{row: row, column: column}) do
        positions
        |> Tuple.to_list
        |> Enum.at(get_index(row, column))
    end

    def put_mark(positions, %{row: row, column: column}, mark) do
        positions
        |> put_elem(get_index(row, column), mark)
    end

    def available_positions(positions) do
        for position <- decompound_positions(positions),
        {mark, index} = position,
        !position_occupied?(mark) do
            row_column(index)
        end
    end

    defp position_occupied?(mark), do: mark != nil

    defp get_index(row, column), do: row * 3 + column

    defp decompound_positions(positions) do
        positions |> Tuple.to_list |> Enum.with_index
    end

    defp row_column(index) do
        %{row: div(index, 3), column: rem(index, 3)}
    end

end
