defmodule GameEngine.PlayStrategies.KickAssMoves do

    alias GameEngine.PlayStrategies.Moves

    def all(), do: [Moves.Win, Moves.BlockWin, Moves.Fork,
                    Moves.AttackOpponentsFork, Moves.BlockFork,
                    Moves.ForceFork, Moves.Center, Moves.EmptyCorner, Moves.EmptySide]

end
