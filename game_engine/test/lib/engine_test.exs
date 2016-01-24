defmodule GameEngine.EngineTest do
	use ExUnit.Case

	import Mock

	setup do
		{:ok, engine} = GameEngine.Engine.start_link
		{:ok, engine: engine}
	end

	test "returns a new game when initializing", %{engine: engine} do
		{:ok, new_game} = GameEngine.Engine.initialize(engine, GameEngine.GameType.computer_computer)

		assert new_game[:board] == %{}
		assert new_game[:x] == nil
		assert new_game[:o] == nil
	end

	test "new initialized game contains an id", %{engine: engine} do
		game_id = "38c5c34f-6d33-4618-bb5f-9a9f1890ff8d"
		with_mock GameEngine.GameIdGenerator, [new: fn() -> game_id end] do
			{:ok, new_game} = GameEngine.Engine.initialize(engine, GameEngine.GameType.computer_computer)

			assert new_game[:game_id] == game_id
		end
	end

	test "receive error if game to start is not the initialized game", %{engine: engine} do
		GameEngine.Engine.initialize(engine, GameEngine.GameType.computer_computer)
		different_game_id = 12;

		{:error, error} = GameEngine.Engine.start(engine, different_game_id)

		assert error == "Invalid game_id provided"
	end

	test "get an empty board when starting game", %{engine: engine} do
		{:ok, new_game} = GameEngine.Engine.initialize(engine, GameEngine.GameType.computer_computer)
		
		{:ok, game} = GameEngine.Engine.start(engine, new_game[:game_id])

		assert game[:board] == %GameEngine.Board{}
	end

	test "get Star Wars robots as players when starting game if type is computer-versus-computer", %{engine: engine} do
		{:ok, new_game} = GameEngine.Engine.initialize(engine, GameEngine.GameType.computer_computer)

		{:ok, game} = GameEngine.Engine.start(engine, new_game[:game_id])
		assert game[:o] == :r2d2
		assert game[:x] == :c3po		
	end
end