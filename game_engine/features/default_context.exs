defmodule GameEngine.DefaultContext do
  use WhiteBread.Context

  subcontext GameEngine.PlayGameFeature

end

defmodule GameEngine.PlayGameFeature do
  use WhiteBread.Context
  use Phoenix.ConnTest

  @endpoint GameEngine.Endpoint

  given_ ~r/^I select a Computer vs Computer game$/, fn state ->
    {:ok, state |> Dict.put(:type, GameEngine.GameType.computer_computer)}
  end

  when_ ~r/^I request to initiate the game/, fn state ->    
    game_type = state |> Dict.get(:type)
    params = Poison.encode!(%{Type: game_type})

    response = conn()
    |> content_type_json
    |> post("/initiate", params)
    
    {:ok, state |> Dict.put(:response, response)}
  end

  then_ "I get a new initiated game", fn state ->
    game_type = state |> Dict.get(:type)
    response = state |> Dict.get(:response)
    decoded_response = json_response(response, 200)

    assert decoded_response["Status"] == "init"
    assert decoded_response["Type"] == game_type
    refute decoded_response["GameId"] == ""

    {:ok, state}
  end

  defp content_type_json(conn) do
    put_req_header(conn(), "content-type", "application/json")
  end
end