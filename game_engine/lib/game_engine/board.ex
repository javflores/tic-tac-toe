defmodule GameEngine.Board do

    @players [:o, :x]
    @board_dimension 3

    def get_empty(), do: for _position <- 1..@board_dimension*@board_dimension, do: nil

    def resolve_winner(board) do
        cond do
            :winner == winner(board) ->
                :winner
            full?(board) ->
                :draw
            true ->
                :no_result
        end
    end

    def winner(board) do
        o_win = for _index <- 1..@board_dimension, do: :o
        x_win = for _index <- 1..@board_dimension, do: :x
        get_groups(board)
        |> Enum.any?(fn(group) -> group == o_win or group == x_win end)
        |> do_winner
    end

    def full?(board) do
        board
        |> Enum.all?(fn(position) -> position_occupied?(position) end)
    end

    def get_groups(board) do
        get_rows(board) ++ get_columns(board) ++ get_diagonals(board)
    end

     def get_rows(board) do
        board
        |> Enum.chunk(@board_dimension)
    end

    def get_columns(board) do
        for column_index <- 0..@board_dimension-1, do: get_column(column_index, board)
    end

    def get_column(column_index, board) do
        board
        |> Enum.drop(column_index)
        |> Enum.take_every(@board_dimension)
    end

    def get_diagonals(board) do
        [first_diagonal(board)|[second_diagonal(board)]]
    end

    def first_diagonal(board) do
        first_diagonal_indexes = Stream.iterate(0, fn(index) -> index + @board_dimension + 1 end)
        |> Enum.take(@board_dimension)

        get_diagonal(first_diagonal_indexes, board)
    end

    def second_diagonal(board) do
        second_diagonal_indexes = Stream.iterate(@board_dimension-1, fn(index) -> index + @board_dimension - 1 end)
        |> Enum.take(@board_dimension)

        get_diagonal(second_diagonal_indexes, board)
    end

    def get_diagonal(diagonal_indexes, board) do
        for diagonal_index <- diagonal_indexes, do: Enum.at(board, diagonal_index)
    end

    def get_by_position(board, %{row: row, column: column}) do
        board
        |> Enum.at(get_index(row, column))
    end

    def put_mark(board, %{row: row, column: column}, mark) do
        board
        |> List.to_tuple
        |> put_elem(get_index(row, column), mark)
        |> Tuple.to_list
    end

    def available_positions(board) do
        for position <- decompound_positions(board), {mark, index} = position,
        !position_occupied?(mark) do
            row_column(index)
        end
    end

    defp position_occupied?(mark), do: mark != nil

    defp get_index(row, column), do: row * @board_dimension + column

    defp decompound_positions(board) do
        board |> Enum.with_index
    end

    defp row_column(index) do
        %{row: div(index, @board_dimension), column: rem(index, @board_dimension)}
    end

    defp do_winner(true), do: :winner
    defp do_winner(false), do: :no_winner

end
