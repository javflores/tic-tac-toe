defmodule GameEngine.PlayStrategies.Moves.BlockWin do
	
	@behaviour GameEngine.PlayStrategies.Move

	def find(board, player) do
		board
		|> GameEngine.PlayStrategies.Moves.Win.find(GameEngine.Player.know_your_enemy(player))
	end
end