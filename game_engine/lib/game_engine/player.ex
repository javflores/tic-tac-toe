defmodule GameEngine.Player do

    def move(board, mark) do
        GameEngine.PlayStrategies.KickAssStrategy.calculate_move(board, mark)
        |> put_mark(board, mark)
    end

    def move(board, position, mark) do
        GameEngine.Board.put_mark(board, position, mark)
    end

    defp put_mark(:not_found, board, _mark), do: board
    defp put_mark(position, board, mark), do: GameEngine.Board.put_mark(board, position, mark)

    def know_your_enemy(:o), do: :x
    def know_your_enemy(:x), do: :o

end
