defmodule GameEngine.EngineControllerTest do
	use ExUnit.Case
	use Phoenix.ConnTest

	test "initiate computer versus computer game" do
		response = GameEngine.EngineController.initiate(conn, %{"Type" => GameEngine.GameType.computer_computer})

		decoded_response = json_response(response, 200)
		assert decoded_response["Status"] == "init"
		assert decoded_response["Type"] == GameEngine.GameType.computer_computer
	end	
end