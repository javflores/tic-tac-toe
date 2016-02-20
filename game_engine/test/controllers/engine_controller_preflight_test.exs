defmodule GameEngine.EngineControllerPreflightTest do
    use ExUnit.Case
    use Phoenix.ConnTest

    test "get 200 empty response when a preflight request is sent" do
        response = GameEngine.EngineController.preflight(conn, %{})

        assert response.status == 200
        assert response.resp_body == ""
    end
end
