defmodule GameEngine.GameTest do
	use ExUnit.Case

	import Mock

	setup do
		{:ok, game} = GameEngine.Game.start_link
		{:ok, game: game}
	end

	test "returns a new game when initializing", %{game: game} do
		{:ok, new_game} = GameEngine.Game.initialize(game, GameEngine.GameType.computer_computer, "R2-D2", "C-3PO")

		assert new_game[:board] == %{}
		assert new_game[:o] == "R2-D2"
		assert new_game[:x] == "C-3PO"
	end

	test "new initialized game contains an id", %{game: game} do
		game_id = "38c5c34f-6d33-4618-bb5f-9a9f1890ff8d"
		with_mock GameEngine.GameIdGenerator, [new: fn() -> game_id end] do
			{:ok, new_game} = GameEngine.Game.initialize(game, GameEngine.GameType.computer_computer, "R2-D2", "C-3PO")

			assert new_game[:game_id] == game_id
		end
	end

	test "receive error if game to start is not the initialized game", %{game: game} do
		GameEngine.Game.initialize(game, GameEngine.GameType.computer_computer, "R2-D2", "C-3PO")
		different_game_id = 12;

		{:error, error} = GameEngine.Game.start(game, different_game_id, "R2-D2")

		assert error == "Invalid game_id provided"
	end

	test "get an empty board when starting game", %{game: game} do
		{:ok, new_game} = GameEngine.Game.initialize(game, GameEngine.GameType.computer_computer, "R2-D2", "C-3PO")
		
		{:ok, game} = GameEngine.Game.start(game, new_game[:game_id], "R2-D2")

		assert game[:board] == %GameEngine.Board{}
	end

	test "assign first player when game starts", %{game: game} do
		{:ok, new_game} = GameEngine.Game.initialize(game, GameEngine.GameType.computer_computer, "R2-D2", "C-3PO")
		
		first_player = "R2-D2"
		{:ok, game} = GameEngine.Game.start(game, new_game[:game_id], first_player)

		assert game[:next_player] == first_player
	end

	test "receive error when the provided first player is not part of the game", %{game: game} do
		{:ok, new_game} = GameEngine.Game.initialize(game, GameEngine.GameType.computer_computer, "R2-D2", "C-3PO")
		
		player_not_part_of_game = "Intruder"
		{:error, error} = GameEngine.Game.start(game, new_game[:game_id], player_not_part_of_game)

		assert error == "Invalid first player provided, not part of the game"
	end
end