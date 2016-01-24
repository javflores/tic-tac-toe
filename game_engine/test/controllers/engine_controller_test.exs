defmodule GameEngine.EngineControllerTest do
	use ExUnit.Case
	use Phoenix.ConnTest
	import Mock

	setup do
		{:ok, engine} = GameEngine.Engine.start_link
		{:ok, engine: engine}
	end

	test "get initialized computer-versus-computer game" do
		response = GameEngine.EngineController.initialize(conn, %{"type" => GameEngine.GameType.computer_computer})

		decoded_response = json_response(response, 200)
		assert decoded_response["status"] == "init"
		assert decoded_response["type"] == GameEngine.GameType.computer_computer
	end

	test "get initialized game based on Engine" do
		game_type = GameEngine.GameType.computer_computer
		with_mock GameEngine.Engine, [:passthrough], [initialize: fn(_engine, _type) -> {:ok, %{game_id: 123, board: %{}, x: nil, o: nil}} end] do
			response = GameEngine.EngineController.initialize(conn, %{"type" => game_type})

			decoded_response = json_response(response, 200)
			assert decoded_response["board"] == %{}
			assert decoded_response["x"] == nil
			assert decoded_response["o"] == nil	
		end
	end

	test "returns new game with id when initializing" do
		game_id = "38c5c34f-6d33-4618-bb5f-9a9f1890ff8d"
		with_mock GameEngine.Engine, [:passthrough], [initialize: fn(_engine, _type) -> {:ok, %{game_id: game_id, board: %{}, x: nil, o: nil}} end] do
			response = GameEngine.EngineController.initialize(conn, %{"type" => GameEngine.GameType.computer_computer})

			decoded_response = json_response(response, 200)
			assert decoded_response["game_id"] == game_id	
		end
	end

	test "get started game based on engine" do
		with_mock GameEngine.Engine, [:passthrough], [start: fn(_engine, _game_id) -> {:ok, %{board: %GameEngine.Board{}, x: :r2d2, o: :c3po}} end] do
			response = GameEngine.EngineController.start(conn, %{"game_id" => "aa022760-c2c2-11e5-a5c7-3ca9f4aa918d"})

			decoded_response = json_response(response, 200)
			assert decoded_response["board"] == [nil, nil, nil, nil, nil, nil, nil, nil, nil]
			assert decoded_response["x"] == "r2d2"
			assert decoded_response["o"] == "c3po"
		end
	end

	test "get error upon game start when engines sends an error" do
		with_mock GameEngine.Engine, [:passthrough], [start: fn(_engine, _game_id) -> {:error, "Invalid game_id provided"} end] do
			response = GameEngine.EngineController.start(conn, %{"game_id" => "aa022760-c2c2-11e5-a5c7-3ca9f4aa918d"})

			decoded_response = json_response(response, 400)
			assert decoded_response == "Invalid game_id provided"
		end
	end
end