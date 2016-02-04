defmodule GameEngine.EngineControllerTest do
	use ExUnit.Case
	use Phoenix.ConnTest
	import Mock

	test "get started game" do
		with_mock GameEngine.Game, [:passthrough], 
		[start: fn(_game, _players) -> {:ok, %{game_id: "", board: %GameEngine.Board{}, next_player: "", x: "", o: "", type: :computer_computer}} end] do
			response = GameEngine.EngineController.start(
				conn, %{"o_name" => "C-3PO", "o_type" => "computer", "x_name" => "R2-D2", "x_type" => "computer", "first_player" => "C-3PO"})

			decoded_response = json_response(response, 200)
			assert decoded_response["status"] == "start"
		end
	end

	test "returns new game with id when starting" do
		game_id = "38c5c34f-6d33-4618-bb5f-9a9f1890ff8d"
		with_mock GameEngine.Game, [:passthrough], 
		[start: fn(_game, _players) -> {:ok, %{game_id: game_id, board: %GameEngine.Board{}, next_player: "", x: "", o: "", type: :computer_computer}} end] do
			response = GameEngine.EngineController.start(
				conn, %{"o_name" => "C-3PO", "o_type" => "computer", "x_name" => "R2-D2", "x_type" => "computer", "first_player" => "C-3PO"})

			decoded_response = json_response(response, 200)
			assert decoded_response["game_id"] == game_id
		end
	end

	test "get empty board when game started" do
		with_mock GameEngine.Game, [:passthrough], 
		[start: fn(_game, _players) -> {:ok, %{game_id: "", board: %GameEngine.Board{}, next_player: "C-3PO", x: "C-3PO", o: "R2-D2", type: :computer_computer}} end] do
			response = GameEngine.EngineController.start(
				conn, %{"o_name" => "C-3PO", "o_type" => "computer", "x_name" => "R2-D2", "x_type" => "computer", "first_player" => "C-3PO"})

			decoded_response = json_response(response, 200)
			assert decoded_response["board"] == [nil, nil, nil, nil, nil, nil, nil, nil, nil]
		end
	end

	test "get players for started game" do
		with_mock GameEngine.Game, [:passthrough], 
		[start: fn(_game, _players) -> {:ok, %{game_id: "", board: %GameEngine.Board{}, next_player: "C-3PO", x: "R2-D2", o: "C-3PO", type: :computer_computer}} end] do
			response = GameEngine.EngineController.start(
				conn, %{"o_name" => "C-3PO", "o_type" => "computer", "x_name" => "R2-D2", "x_type" => "computer", "first_player" => "C-3PO"})

			decoded_response = json_response(response, 200)
			assert decoded_response["o"] == "C-3PO"
			assert decoded_response["x"] == "R2-D2"
		end
	end

	test "get type of game" do
		with_mock GameEngine.Game, [:passthrough], 
		[start: fn(_game, _players) -> {:ok, %{game_id: "", board: %GameEngine.Board{}, next_player: "C-3PO", x: "C-3PO", o: "R2-D2", type: :computer_computer}} end] do
			response = GameEngine.EngineController.start(
				conn, %{"o_name" => "C-3PO", "o_type" => "computer", "x_name" => "R2-D2", "x_type" => "computer", "first_player" => "C-3PO"})

			decoded_response = json_response(response, 200)
			assert decoded_response["type"] == "computer_computer"
		end
	end

	test "next player to play is the specified first player" do
		with_mock GameEngine.Game, [:passthrough], 
		[start: fn(_game, _players) -> {:ok, %{game_id: "", board: %GameEngine.Board{}, next_player: "C-3PO", x: "C-3PO", o: "R2-D2", type: :computer_computer}} end] do
			response = GameEngine.EngineController.start(
				conn, %{"o_name" => "C-3PO", "o_type" => "computer", "x_name" => "R2-D2", "x_type" => "computer", "first_player" => "C-3PO"})

			decoded_response = json_response(response, 200)
			assert decoded_response["next_player"] == "C-3PO"
		end
	end

	test "get error upon game start when game returns an error" do
		expected_error = "Invalid game_id provided"
		with_mock GameEngine.Game, [:passthrough], 
		[start: fn(_game, _players) -> {:error, expected_error} end] do
			response = GameEngine.EngineController.start(
				conn, %{"o_name" => "C-3PO", "o_type" => "computer", "x_name" => "R2-D2", "x_type" => "computer", "first_player" => "C-3PO"})

			decoded_response = json_response(response, 400)
			assert decoded_response == expected_error
		end
	end

	test "get status returned by game upon player moves" do
		expected_status = :in_progress
		with_mock GameEngine.Game, [:passthrough], 
			[move: fn(_game, _game_id) -> {:ok, %{status: expected_status, player: "", next_player: "", board: %GameEngine.Board{}}} end] do

			response = GameEngine.EngineController.move(conn, %{"game_id" => "aa022760-c2c2-11e5-a5c7-3ca9f4aa918d"})

			decoded_response = json_response(response, 200)
			assert decoded_response["status"] == Atom.to_string(expected_status)
		end
	end

	test "get board after player moves" do
		board = {nil, nil, nil, nil, nil, :x, nil, nil, nil}
		with_mock GameEngine.Game, [:passthrough], 
			[move: fn(_game, _game_id) -> {:ok, %{board: %GameEngine.Board{positions: board}, status: "", player: "", next_player: ""}} end] do
			
			response = GameEngine.EngineController.move(conn, %{"game_id" => "aa022760-c2c2-11e5-a5c7-3ca9f4aa918d"})

			decoded_response = json_response(response, 200)
			assert decoded_response["board"] == [nil, nil, nil, nil, nil, "x", nil, nil, nil]
		end
	end

	test "get next player after player moves" do
		expected_next_player = "R2-D2"
		with_mock GameEngine.Game, [:passthrough], 
			[move: fn(_game, _game_id) -> {:ok, %{next_player: expected_next_player, player: "", board: %GameEngine.Board{}, status: ""}} end] do
			
			response = GameEngine.EngineController.move(conn, %{"game_id" => "aa022760-c2c2-11e5-a5c7-3ca9f4aa918d"})

			decoded_response = json_response(response, 200)
			assert decoded_response["next_player"] == expected_next_player
		end
	end

	test "returns winner if there is one" do
		winner = "R2-D2"
		with_mock GameEngine.Game, [:passthrough], 
			[move: fn(_game, _game_id) -> {:winner, %{status: :winner, winner: winner, next_player: "", player: "", board: %GameEngine.Board{}}} end] do
			
			response = GameEngine.EngineController.move(conn, %{"game_id" => "aa022760-c2c2-11e5-a5c7-3ca9f4aa918d"})

			decoded_response = json_response(response, 200)
			assert decoded_response["status"] == "winner"
			assert decoded_response["winner"] == winner
		end
	end

	test "returns draw" do
		expected_status = :draw
		with_mock GameEngine.Game, [:passthrough], 
			[move: fn(_game, _game_id) -> {:ok, %{status: expected_status, player: "", next_player: "", board: %GameEngine.Board{}}} end] do

			response = GameEngine.EngineController.move(conn, %{"game_id" => "aa022760-c2c2-11e5-a5c7-3ca9f4aa918d"})

			decoded_response = json_response(response, 200)
			assert decoded_response["status"] == Atom.to_string(expected_status)
		end
	end

	test "human player moves" do
		with_mock GameEngine.Game, [:passthrough], 
			[move: fn(_game, _game_id, _move) -> 
				{:ok, %{board: %GameEngine.Board{positions: {nil, nil, nil, nil, nil, :x, nil, nil, nil}}, status: "", player: "", next_player: ""}} end] do
			
			response = GameEngine.EngineController.move(conn, %{"game_id" => "aa022760-c2c2-11e5-a5c7-3ca9f4aa918d", "move" => %{"column" => 1, "row" => 1}})

			human_move = %{row: 1, column: 1}
			assert called GameEngine.Game.move(:_, :_, human_move)
		end
	end
end