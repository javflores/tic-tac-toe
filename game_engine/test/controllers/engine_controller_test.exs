defmodule GameEngine.EngineControllerTest do
	use ExUnit.Case
	use Phoenix.ConnTest
	import Mock

	setup do
		{:ok, engine} = GameEngine.Engine.start_link
		{:ok, engine: engine}
	end

	test "get initiated computer versus computer game" do
		response = GameEngine.EngineController.initiate(conn, %{"type" => GameEngine.GameType.computer_computer})

		decoded_response = json_response(response, 200)
		assert decoded_response["status"] == "init"
		assert decoded_response["type"] == GameEngine.GameType.computer_computer
	end

	test "returns new game when initiating based on Engine" do
		game_type = GameEngine.GameType.computer_computer
		with_mock GameEngine.Engine, [:passthrough], [initiate: fn(_engine, _type) -> {:ok, %{status: :init, type: game_type, board: %{}, x: nil, o: nil}} end] do
			response = GameEngine.EngineController.initiate(conn, %{"Type" => game_type})

			decoded_response = json_response(response, 200)
			new_game = decoded_response["game"]
			assert new_game["board"] == %{}
			assert new_game["x"] == nil
			assert new_game["o"] == nil			
		end
	end
end