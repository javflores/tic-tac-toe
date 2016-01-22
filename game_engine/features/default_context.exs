defmodule GameEngine.DefaultContext do
  use WhiteBread.Context

  subcontext GameEngine.PlayGameFeature

end

defmodule GameEngine.PlayGameFeature do
  use WhiteBread.Context
  use Phoenix.ConnTest

  @endpoint GameEngine.Endpoint

  given_ ~r/^I select a Computer vs Computer game$/, fn state ->
    {:ok, state |> Dict.put(:type, "computer_computer")}
  end

  when_ ~r/^I request to initiate the game/, fn state ->
    game_type = state |> Dict.get(:type)
    response = post(conn(), "/start", [type: game_type])
    {:ok, state |> Dict.put(:response, response)}
  end

  then_ "I get a new initiated game", fn state ->
    response = state |> Dict.get(:response)
    decode_body = json_response(response, 200)
    game_status = decode_body["status"]
    assert game_status == "init"
    {:ok, state}
  end
end