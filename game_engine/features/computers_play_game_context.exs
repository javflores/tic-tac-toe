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
    game_id = request_initialized_game

    {:ok, state |> Dict.put(:game_id, game_id)}
  end

  when_ ~r/^I choose to start the game$/, fn state ->
    game_id = state |> Dict.get(:game_id)

    response = request_to_start_game(game_id)

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

  given_ ~r/^I have started a new Computer vs Computer game$/, fn state ->
    game_id = request_initialized_game
    response = request_to_start_game(game_id)

    {:ok, state |> Dict.put(:game_id, game_id)}
  end

  when_ ~r/^I choose to get a computer to move$/, fn state ->
    game_id = state |> Dict.get(:game_id)
    response = move(game_id)

    {:ok, state |> Dict.put(:response, response)}
  end

  then_ ~r/^I get the computers move$/, fn state ->
    response = state |> Dict.get(:response)
    decoded_response = json_response(response, 200)
    move = decoded_response["move"]

    assert move[:player] == "r2d2"
    refute move[:position] == ""

    {:ok, state}
  end

  then_ ~r/^I get the new positions in the board$/, fn state ->
    response = state |> Dict.get(:response)
    decoded_response = json_response(response, 200)
    
    refute decoded_response["board"] == [nil, nil, nil, nil, nil, nil, nil, nil, nil]

    {:ok, state}
  end

  then_ ~r/^the game is in progress$/, fn state ->
    response = state |> Dict.get(:response)
    decoded_response = json_response(response, 200)
    
    assert decoded_response["status"] == "in_progress"

    {:ok, state}
  end

  defp request_initialized_game do
    params = Poison.encode!(%{type: GameEngine.GameType.computer_computer})

    response = conn()
    |> content_type_json
    |> post("/initialize", params)

    decoded_response = json_response(response, 200)
    decoded_response["game_id"]
  end

  defp request_to_start_game(game_id) do
    conn()
    |> content_type_json
    |> post("/start/#{game_id}")
  end

  defp move(game_id) do
    conn()
    |> post("/move/#{game_id}")
  end

  defp content_type_json(conn) do
    put_req_header(conn, "content-type", "application/json")
  end
end