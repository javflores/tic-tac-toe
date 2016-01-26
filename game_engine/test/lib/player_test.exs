defmodule GameEngine.PlayerTest do
	use ExUnit.Case

	setup do
		{:ok, player} = GameEngine.Player.start_link
		{:ok, player: player}
	end

	test "player assigns his name", %{player: player} do
		{:ok, player_initialization} = GameEngine.Player.initialize(player, "R2-D2", :computer_computer)

		assert player_initialization[:name] == "R2-D2"
	end

	test "player will play simple if two computers are going to play", %{player: player} do
		{:ok, player_initialization} = GameEngine.Player.initialize(player, "R2-D2", :computer_computer)

		assert player_initialization[:strategy] == :simple
	end
end