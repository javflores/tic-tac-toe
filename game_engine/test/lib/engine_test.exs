defmodule GameEngine.EngineTest do
	use ExUnit.Case

	import Mock

	setup do
		{:ok, engine} = GameEngine.Engine.start_link
		{:ok, engine: engine}
	end

	test "returns a new game when initializing", %{engine: engine} do
		{:ok, new_game} = GameEngine.Engine.initialize(engine, GameEngine.GameType.computer_computer, "R2-D2", "C-3PO")

		assert new_game[:board] == %{}
		assert new_game[:o] == "R2-D2"
		assert new_game[:x] == "C-3PO"
	end

	test "new initialized game contains an id", %{engine: engine} do
		game_id = "38c5c34f-6d33-4618-bb5f-9a9f1890ff8d"
		with_mock GameEngine.GameIdGenerator, [new: fn() -> game_id end] do
			{:ok, new_game} = GameEngine.Engine.initialize(engine, GameEngine.GameType.computer_computer, "R2-D2", "C-3PO")

			assert new_game[:game_id] == game_id
		end
	end

	test "receive error if game to start is not the initialized game", %{engine: engine} do
		GameEngine.Engine.initialize(engine, GameEngine.GameType.computer_computer, "R2-D2", "C-3PO")
		different_game_id = 12;

		{:error, error} = GameEngine.Engine.start(engine, different_game_id, "R2-D2")

		assert error == "Invalid game_id provided"
	end

	test "get an empty board when starting game", %{engine: engine} do
		{:ok, new_game} = GameEngine.Engine.initialize(engine, GameEngine.GameType.computer_computer, "R2-D2", "C-3PO")
		
		{:ok, game} = GameEngine.Engine.start(engine, new_game[:game_id], "R2-D2")

		assert game[:board] == %GameEngine.Board{}
	end

	test "assign first player when game starts", %{engine: engine} do
		{:ok, new_game} = GameEngine.Engine.initialize(engine, GameEngine.GameType.computer_computer, "R2-D2", "C-3PO")
		
		first_player = "R2-D2"
		{:ok, game} = GameEngine.Engine.start(engine, new_game[:game_id], first_player)

		assert game[:next_player] == first_player
	end
end