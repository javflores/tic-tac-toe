defmodule GameEngine.Features.DefaultContext do
  use WhiteBread.Context
  use Phoenix.ConnTest

  @endpoint GameEngine.Endpoint

  given_ ~r/^I select two computer players$/, fn state ->
    state = state
    |> Dict.put(:o_type, "computer")
    |> Dict.put(:o_name, "R2-D2")
    |> Dict.put(:x_name, "C-3PO")
    |> Dict.put(:x_type, "computer")
    |> Dict.put(:first_player, "R2-D2")
    {:ok, state}
  end

  when_ ~r/^I choose to start the game/, fn state ->    
    o_name = state |> Dict.get(:o_name)
    o_type = state |> Dict.get(:o_type)
    x_name = state |> Dict.get(:x_name)
    x_type = state |> Dict.get(:x_type)
    first_player = state |> Dict.get(:first_player)

    params = Poison.encode!(%{o_name: o_name, o_type: o_type, x_name: x_name, x_type: x_type, first_player: first_player})

    response = conn()
    |> content_type_json
    |> post("/start", params)
    
    {:ok, state |> Dict.put(:response, response)}
  end

  then_ ~r/^I get a new started game$/, fn state ->
    response = state |> Dict.get(:response)
    decoded_response = json_response(response, 200)

    assert decoded_response["game_id"] != ""
    assert decoded_response["status"] == "start"
    assert decoded_response["board"] == [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    assert decoded_response["next_player"] == "R2-D2"

    {:ok, state}
  end

  given_ ~r/^I have started a new Computer vs Computer game$/, fn state ->
    params = Poison.encode!(%{o_name: "R2-D2", o_type: "computer", x_name: "C-3PO", x_type: "computer", first_player: "R2-D2"})

    response = conn()
    |> content_type_json
    |> post("/start", params)

    decoded_response = json_response(response, 200)
    game_id = decoded_response["game_id"]

    {:ok, state |> Dict.put(:game_id, game_id)}
  end

  when_ ~r/^I choose to get a computer to move$/, fn state ->
    game_id = state |> Dict.get(:game_id)
    response = conn()
    |> post("/move/#{game_id}")

    {:ok, state |> Dict.put(:response, response)}
  end

  then_ ~r/^I get the computers move$/, fn state ->
    response = state |> Dict.get(:response)
    decoded_response = json_response(response, 200)

    assert decoded_response["player"] == "R2-D2"
    assert decoded_response["next_player"] == "C-3PO"
    refute decoded_response["board"] == [nil, nil, nil, nil, nil, nil, nil, nil, nil]

    {:ok, state}
  end

  then_ ~r/^the game is in progress$/, fn state ->
    response = state |> Dict.get(:response)
    decoded_response = json_response(response, 200)
    
    assert decoded_response["status"] == "in_progress"

    {:ok, state}
  end

  given_ ~r/^I have started a human versus computer game$/, fn state ->
    params = Poison.encode!(%{o_name: "Johny", o_type: "human", x_name: "C-3PO", x_type: "computer", first_player: "Johny"})
    response = conn()
    |> content_type_json
    |> post("/start", params)

    decoded_response = json_response(response, 200)
    game_id = decoded_response["game_id"]

      {:ok, state |> Dict.put(:game_id, game_id)}
  end

  when_ ~r/^I provide the human player move$/, fn state ->
      game_id = state |> Dict.get(:game_id)
      params = Poison.encode!(%{move: %{row: 0, column: 0}})

      response = conn()        
      |> content_type_json
      |> post("/move/#{game_id}", params)

      {:ok, state |> Dict.put(:response, response)}
  end

  then_ ~r/^I get the human player move$/, fn state ->
    response = state |> Dict.get(:response)
    decoded_response = json_response(response, 200)

    assert decoded_response["player"] == "Johny"
    assert decoded_response["next_player"] == "C-3PO"
    assert decoded_response["board"] == ["o", nil, nil, nil, nil, nil, nil, nil, nil]

    {:ok, state}
  end

  then_ ~r/^I get the computer opponent move$/, fn state ->
    response = state |> Dict.get(:response)
    decoded_response = json_response(response, 200)

    assert decoded_response["player"] == "C-3PO"
    assert decoded_response["next_player"] == "Johny"
    assert decoded_response["board"] == ["o", nil, nil, nil, "x", nil, nil, nil, nil]

    {:ok, state}
  end

  given_ ~r/^I have started a human versus human game$/, fn state ->
    params = Poison.encode!(%{o_name: "Johny", o_type: "human", x_name: "Richard", x_type: "human", first_player: "Johny"})
    response = conn()
    |> content_type_json
    |> post("/start", params)

    decoded_response = json_response(response, 200)

    game_id = decoded_response["game_id"]

    {:ok, state |> Dict.put(:game_id, game_id)}
  end

  when_ ~r/^I provide first human move$/, fn state ->
      game_id = state |> Dict.get(:game_id)
      params = Poison.encode!(%{move: %{row: 0, column: 0}})

      response = conn()        
      |> content_type_json
      |> post("/move/#{game_id}", params)

      {:ok, state |> Dict.put(:response, response)}
  end

  then_ ~r/^I get the first human player move$/, fn state ->
    response = state |> Dict.get(:response)
    decoded_response = json_response(response, 200)

    assert decoded_response["player"] == "Johny"
    assert decoded_response["next_player"] == "Richard"
    assert decoded_response["board"] == ["o", nil, nil, nil, nil, nil, nil, nil, nil]

    {:ok, state}
  end

  when_ ~r/^I provide second human move$/, fn state ->
      game_id = state |> Dict.get(:game_id)
      params = Poison.encode!(%{move: %{row: 1, column: 1}})

      response = conn()        
      |> content_type_json
      |> post("/move/#{game_id}", params)

      {:ok, state |> Dict.put(:response, response)}
  end

  then_ ~r/^I get the second human move$/, fn state ->
    response = state |> Dict.get(:response)
    decoded_response = json_response(response, 200)

    assert decoded_response["player"] == "Richard"
    assert decoded_response["next_player"] == "Johny"
    assert decoded_response["board"] == ["o", nil, nil, nil, "x", nil, nil, nil, nil]

    {:ok, state}
  end

  defp content_type_json(conn) do
    put_req_header(conn, "content-type", "application/json")
  end
end