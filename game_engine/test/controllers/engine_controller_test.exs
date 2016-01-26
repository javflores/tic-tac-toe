defmodule GameEngine.EngineControllerTest do
	use ExUnit.Case
	use Phoenix.ConnTest
	import Mock

	setup do
		{:ok, engine} = GameEngine.Game.start_link
		{:ok, engine: engine}
	end

	test "get initialized computer-versus-computer game" do
		response = GameEngine.EngineController.initialize(conn, %{"type" => GameEngine.GameType.computer_computer, "o" => "C-3PO", "x" => "R2-D2"})

		decoded_response = json_response(response, 200)
		assert decoded_response["status"] == "init"
		assert decoded_response["x"] == "R2-D2"
		assert decoded_response["o"] == "C-3PO"
	end

	test "get empty when game is initialized" do
		game_type = GameEngine.GameType.computer_computer
		with_mock GameEngine.Game, [:passthrough], [initialize: fn(_game, _type, _o, _x) -> {:ok, %{game_id: 123, board: %{}, x: "C-3PO", o: "R2-D2"}} end] do
			response = GameEngine.EngineController.initialize(conn, %{"type" => game_type, "o" => "C-3PO", "x" => "R2-D2"})

			decoded_response = json_response(response, 200)
			assert decoded_response["board"] == %{}
		end
	end

	test "returns new game with id when initializing" do
		game_id = "38c5c34f-6d33-4618-bb5f-9a9f1890ff8d"
		with_mock GameEngine.Game, [:passthrough], [initialize: fn(_game, _type, _o, _x) -> {:ok, %{game_id: game_id, board: %{}, x: "C-3PO", o: "R2-D2"}} end] do
			response = GameEngine.EngineController.initialize(conn, %{"type" => GameEngine.GameType.computer_computer, "o" => "C-3PO", "x" => "R2-D2"})

			decoded_response = json_response(response, 200)
			assert decoded_response["game_id"] == game_id
		end
	end

	test "get started game based" do
		with_mock GameEngine.Game, [:passthrough], [start: fn(_game, _game_id, _first_player) -> {:ok, %{board: %GameEngine.Board{}, next_player: "C-3PO"}} end] do
			response = GameEngine.EngineController.start(conn, %{"game_id" => "aa022760-c2c2-11e5-a5c7-3ca9f4aa918d", "first_player" => "C-3PO"})

			decoded_response = json_response(response, 200)
			assert decoded_response["board"] == [nil, nil, nil, nil, nil, nil, nil, nil, nil]
			assert decoded_response["status"] == "start"
		end
	end

	test "specifying first player when starting a new game" do
		with_mock GameEngine.Game, [:passthrough], [start: fn(_game, _game_id, _first_player) -> {:ok, %{board: %GameEngine.Board{}, next_player: "C-3PO"}} end] do
			response = GameEngine.EngineController.start(conn, %{"game_id" => "aa022760-c2c2-11e5-a5c7-3ca9f4aa918d", "first_player" => "C-3PO"})

			decoded_response = json_response(response, 200)
			assert decoded_response["next_player"] == "C-3PO"
		end
	end

	test "get error upon game start when game returns an error" do
		expected_error = "Invalid game_id provided"
		with_mock GameEngine.Game, [:passthrough], [start: fn(_game, _game_id, _first_player) -> {:error, expected_error} end] do
			response = GameEngine.EngineController.start(conn, %{"game_id" => "1234", "first_player" => "C-3PO"})

			decoded_response = json_response(response, 400)
			assert decoded_response == expected_error
		end
	end

	test "get move played by computer" do
		expected_player = "C-3PO"
		expected_position = 5
		with_mock GameEngine.Game, [:passthrough], [move: fn(_game, _game_id) -> 
			{:ok, %{player: expected_player, position: expected_position, next_player: "", board: %GameEngine.Board{}, status: ""}} end] do

			response = GameEngine.EngineController.move(conn, %{"game_id" => "aa022760-c2c2-11e5-a5c7-3ca9f4aa918d"})

			decoded_response = json_response(response, 200)
			assert decoded_response["player"] == expected_player
			assert decoded_response["position"] == expected_position
		end
	end

	test "get status return by game" do
		expected_status = :in_progress
		with_mock GameEngine.Game, [:passthrough], [move: fn(_game, _game_id) -> 
			{:ok, %{status: expected_status, player: "", next_player: "", board: %GameEngine.Board{}, position: 1}} end] do

			response = GameEngine.EngineController.move(conn, %{"game_id" => "aa022760-c2c2-11e5-a5c7-3ca9f4aa918d"})

			decoded_response = json_response(response, 200)
			assert decoded_response["status"] == Atom.to_string(expected_status)
		end
	end

	test "get board after player moves" do
		board = {nil, nil, nil, nil, nil, :x, nil, nil, nil}
		with_mock GameEngine.Game, [:passthrough], [move: fn(_game, _game_id) -> 
			{:ok, %{board: %GameEngine.Board{positions: board}, status: "", position: 1, player: "", next_player: ""}} end] do
			
			response = GameEngine.EngineController.move(conn, %{"game_id" => "aa022760-c2c2-11e5-a5c7-3ca9f4aa918d"})

			decoded_response = json_response(response, 200)
			assert decoded_response["board"] == [nil, nil, nil, nil, nil, "x", nil, nil, nil]
		end
	end

	test "get next player after player moves" do
		expected_next_player = "R2-D2"
		with_mock GameEngine.Game, [:passthrough], [move: fn(_game, _game_id) -> 
			{:ok, %{next_player: expected_next_player, player: "", board: %GameEngine.Board{}, status: "", position: 1}} end] do
			
			response = GameEngine.EngineController.move(conn, %{"game_id" => "aa022760-c2c2-11e5-a5c7-3ca9f4aa918d"})

			decoded_response = json_response(response, 200)
			assert decoded_response["next_player"] == expected_next_player
		end
	end
end