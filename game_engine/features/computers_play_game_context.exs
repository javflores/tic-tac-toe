defmodule GameEngine.Features.ComputersPlayGameContext do
  use WhiteBread.Context
  use Phoenix.ConnTest

  @endpoint GameEngine.Endpoint

  given_ ~r/^I select a Computer vs Computer game$/, fn state ->
    {:ok, state |> Dict.put(:type, GameEngine.GameType.computer_computer)}
  end

  when_ ~r/^I request to initialize the game/, fn state ->    
    game_type = state |> Dict.get(:type)
    params = Poison.encode!(%{type: game_type})

    response = conn()
    |> content_type_json
    |> post("/initialize", params)
    
    {:ok, state |> Dict.put(:response, response)}
  end

  then_ "I get a new initialized game", fn state ->
    game_type = state |> Dict.get(:type)
    response = state |> Dict.get(:response)
    decoded_response = json_response(response, 200)

    assert decoded_response["status"] == "init"
    assert decoded_response["type"] == game_type
    assert decoded_response["board"] == %{}
    assert decoded_response["o"] == nil
    assert decoded_response["x"] == nil

    {:ok, state}
  end

  given_ ~r/^I have initialized a new Computer vs Computer game$/, fn state ->
    params = Poison.encode!(%{type: GameEngine.GameType.computer_computer})

    response = conn()
    |> content_type_json
    |> post("/initialize", params)

    decoded_response = json_response(response, 200)
    game_id = decoded_response["game_id"]

    {:ok, state |> Dict.put(:game_id, game_id)}
  end

  when_ ~r/^I choose to start the game$/, fn state ->
    game_id = state |> Dict.get(:game_id)

    response = conn()
    |> content_type_json
    |> post("/start/#{game_id}")

    {:ok, state |> Dict.put(:response, response)}
  end

  then_ ~r/^I get a new started game$/, fn state ->
    response = state |> Dict.get(:response)
    decoded_response = json_response(response, 200)

    assert decoded_response["status"] == "start"
    refute decoded_response["x"] == nil
    refute decoded_response["o"] == nil
    assert decoded_response["board"] == [nil, nil, nil, nil, nil, nil, nil, nil, nil]

    {:ok, state}
  end

  defp content_type_json(conn) do
    put_req_header(conn, "content-type", "application/json")
  end
end