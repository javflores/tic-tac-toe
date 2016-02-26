defmodule GameEngine.Board do

    @players [:o, :x]

    def get_empty(), do: {nil, nil, nil,
                          nil, nil, nil,
                          nil, nil, nil}

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

    def get_rows(positions) do
        positions
        |> Tuple.to_list
        |> Enum.chunk(3)
    end

    def get_columns(positions) do
        {first_column, tail} = group_first_column(positions)

        {second_column, third_column} = group_second_third(tail)

        chunk_columns(first_column, second_column, third_column)
    end

    def get_diagonals({c1, _, c2,
                       _, c3, _,
                       c4, _, c5}), do: [[c1, c3, c5], [c2, c3, c4]]

    def find_triples(positions) do
        rows = GameEngine.Board.get_rows(positions)
        columns = GameEngine.Board.get_columns(positions)
        diagonals = GameEngine.Board.get_diagonals(positions)

        %{rows: rows, columns: columns, diagonals: diagonals}
    end

    def two_empty_spaces_triples_in_board(positions, player) do
        %{rows: rows, columns: columns, diagonals: diagonals} = GameEngine.Board.find_triples(positions)
        %{rows: two_empty_spaces(rows, player), columns: two_empty_spaces(columns, player), diagonals: two_empty_spaces(diagonals, player)}
    end

    def two_empty_spaces(triples, player) do
        triples
        |> Enum.with_index
        |> Enum.filter(&two_empty_spaces?(&1, player))
    end

    def two_empty_spaces?({[mark, nil, nil], _}, player), do: mark == player
    def two_empty_spaces?({[nil, mark, nil], _}, player), do: mark == player
    def two_empty_spaces?({[nil, nil, mark], _}, player), do: mark == player
    def two_empty_spaces?({[_, _, _], _}, _), do: false

    defp group_first_column(positions) do
        positions
        |> Tuple.to_list
        |> Enum.with_index
        |> Enum.partition(fn({_mark, index}) -> rem(index, 3) == 0 end)
    end

    defp group_second_third(second_third) do
        second_third
        |> Enum.partition(fn({_mark, index}) -> rem(index, 3) == 1 end)
    end

    defp chunk_columns(first_column, second_column, third_column) do
        first_column ++ second_column ++ third_column
        |> Enum.map(fn({mark, _index}) -> mark end)
        |> Enum.chunk(3)
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
