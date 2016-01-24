defmodule GameEngine.EngineTest do
	use ExUnit.Case

	setup do
		{:ok, engine} = GameEngine.Engine.start_link
		{:ok, engine: engine}
	end

	test "returns a new game when initiating", %{engine: engine} do
		game_type = GameEngine.GameType.computer_computer

		{:ok, new_game} = GameEngine.Engine.initiate(engine, game_type)

		assert new_game == %{board: %{}, x: nil, o: nil}
	end
end