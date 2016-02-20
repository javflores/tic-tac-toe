defmodule GameEngine.PlayStrategies.Moves.BlockFork do

    @behaviour GameEngine.PlayStrategies.Move

    def find(board, player) do
        board
        |> GameEngine.PlayStrategies.Moves.Fork.find(GameEngine.Player.know_your_enemy(player))
    end
end
