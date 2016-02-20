defmodule GameEngine.Board do

    @players [:o, :x]

    defstruct positions: {nil, nil, nil,
                          nil, nil, nil,
                          nil, nil, nil}

    def resolve_winner(%GameEngine.Board{positions: {player, player, player,
                                                      _, _, _,
                                                      _, _, _}}) when player in @players, do: :winner

    def resolve_winner(%GameEngine.Board{positions: {_, _, _,
                                                     player, player, player,
                                                     _, _, _}}) when player in @players, do: :winner

    def resolve_winner(%GameEngine.Board{positions: {_, _, _,
                                                     _, _, _,
                                                     player, player, player}}) when player in @players, do: :winner

    def resolve_winner(%GameEngine.Board{positions: {player, _, _,
                                                     player, _, _,
                                                     player, _, _}}) when player in @players, do: :winner

    def resolve_winner(%GameEngine.Board{positions: {_, player, _,
                                                     _, player, _,
                                                     _, player, _}}) when player in @players, do: :winner

    def resolve_winner(%GameEngine.Board{positions: {_, _, player,
                                                     _, _, player,
                                                     _, _, player}}) when player in @players, do: :winner

    def resolve_winner(%GameEngine.Board{positions: {_, _, player,
                                                     _, player, _,
                                                     player, _, _}}) when player in @players, do: :winner

    def resolve_winner(%GameEngine.Board{positions: {player, _, _,
                                                     _, player, _,
                                                     _, _, player}}) when player in @players, do: :winner

    def resolve_winner(%GameEngine.Board{positions: _positions}), do: :no_winner

    def full?(%GameEngine.Board{positions: positions}) do
        positions
        |> Tuple.to_list
        |> Enum.all?(fn(position) -> position_occupied?(position) end)
    end

    def get_by_position(%GameEngine.Board{positions: positions}, %{row: row, column: column}) do
        positions
        |> Tuple.to_list
        |> Enum.at(get_index(row, column))
    end

    def put_mark(%GameEngine.Board{positions: positions}, %{row: row, column: column}, mark) do
        new_positions = positions
        |> put_elem(get_index(row, column), mark)

        %GameEngine.Board{positions: new_positions}
    end

    def available_positions(%GameEngine.Board{positions: positions}) do
        for position <- decompound_positions(positions),
        {mark, index} = position,
        !position_occupied?(mark) do
            row_column(index)
        end
    end

    def get_rows(%GameEngine.Board{positions: positions}) do
        positions
        |> Tuple.to_list
        |> Enum.chunk(3)
    end

    def get_columns(%GameEngine.Board{positions: positions}) do
        {first_column, tail} = group_first_column(positions)

        {second_column, third_column} = group_second_third(tail)

        chunk_columns(first_column, second_column, third_column)
    end

    def get_diagonals(%GameEngine.Board{positions: {c1, _, c2,
                                                    _, c3, _,
                                                    c4, _, c5}}), do: [[c1, c3, c5], [c2, c3, c4]]

    def find_triples(%GameEngine.Board{positions: positions}) do
        rows = GameEngine.Board.get_rows(%GameEngine.Board{positions: positions})
        columns = GameEngine.Board.get_columns(%GameEngine.Board{positions: positions})
        diagonals = GameEngine.Board.get_diagonals(%GameEngine.Board{positions: positions})

        %{rows: rows, columns: columns, diagonals: diagonals}
    end

    def two_empty_spaces_triples_in_board(%GameEngine.Board{positions: positions}, player) do
        %{rows: rows, columns: columns, diagonals: diagonals} = GameEngine.Board.find_triples(%GameEngine.Board{positions: positions})
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
