defmodule GameEngine.Player do

    def move(board, mark) do
        case GameEngine.Board.full?(board) do
            true ->
                board
            false ->
                position = GameEngine.Minimax.calculate_move(board, mark)
                GameEngine.Board.put_mark(board, position, mark)
        end
    end

    def move(board, position, mark) do
        GameEngine.Board.put_mark(board, position, mark)
    end

    def know_your_enemy(:o), do: :x
    def know_your_enemy(:x), do: :o

end
