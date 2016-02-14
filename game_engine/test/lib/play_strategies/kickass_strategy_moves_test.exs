defmodule GameEngine.KickAssStrategyMovesTest do
	
	use ExUnit.Case
	alias GameEngine.PlayStrategies.Moves

	test "sends a list of all moves in order" do
		all_moves = GameEngine.PlayStrategies.KickAssMoves.all
		
		assert all_moves == [Moves.Win, Moves.BlockWin, Moves.Fork, Moves.AttackOpponentsFork, 
							Moves.BlockFork, Moves.ForceFork, Moves.Center, Moves.EmptyCorner, Moves.EmptySide]
	end
end