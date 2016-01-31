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
    {:ok, state}
  end

  when_ ~r/^I request to initialize the game/, fn state ->    
    o_name = state |> Dict.get(:o_name)
    o_type = state |> Dict.get(:o_type)
    x_name = state |> Dict.get(:x_name)
    x_type = state |> Dict.get(:x_type)

    params = Poison.encode!(%{o_name: o_name, o_type: o_type, x_name: x_name, x_type: x_type})

    response = conn()
    |> content_type_json
    |> post("/initialize", params)
    
    {:ok, state |> Dict.put(:response, response)}
  end

  then_ "I get a new initialized game", fn state ->
    response = state |> Dict.get(:response)
    decoded_response = json_response(response, 200)

    assert decoded_response["status"] == "init"
    assert decoded_response["type"] == "computer_computer"
    assert decoded_response["board"] == %{}
    assert decoded_response["o"] == "R2-D2"
    assert decoded_response["x"] == "C-3PO"

    {:ok, state}
  end

  given_ ~r/^I have initialized a new Computer vs Computer game$/, fn state ->
    game_id = request_initialized_game_computer_computer

    {:ok, state |> Dict.put(:game_id, game_id)}
  end

  when_ ~r/^I choose to start the game with the first player$/, fn state ->
    game_id = state |> Dict.get(:game_id)

    response = request_to_start_game(game_id, "C-3PO")

    {:ok, state |> Dict.put(:response, response)}
  end

  then_ ~r/^I get a new started game$/, fn state ->
    response = state |> Dict.get(:response)
    decoded_response = json_response(response, 200)

    assert decoded_response["status"] == "start"
    assert decoded_response["board"] == [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    assert decoded_response["next_player"] == "C-3PO"

    {:ok, state}
  end

  given_ ~r/^I have started a new Computer vs Computer game$/, fn state ->
    game_id = request_initialized_game_computer_computer
    response = request_to_start_game(game_id, "C-3PO")

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

    assert decoded_response["player"] == "C-3PO"
    assert decoded_response["next_player"] == "R2-D2"
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
      game_id = request_initialized_game_human_computer("Johny", "C-3PO")
        
      request_to_start_game(game_id, "Johny")

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
      game_id = request_initialized_game_human_human("Johny", "Richard")
        
      request_to_start_game(game_id, "Johny")

      {:ok, state |> Dict.put(:game_id, game_id)}
  end

  when_ ~r/^I provide second human move$/, fn state ->
      game_id = state |> Dict.get(:game_id)
      params = Poison.encode!(%{move: %{row: 1, column: 1}})

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

  then_ ~r/^I get the second human move$/, fn state ->
    response = state |> Dict.get(:response)
    decoded_response = json_response(response, 200)

    assert decoded_response["player"] == "Richard"
    assert decoded_response["next_player"] == "Johny"
    assert decoded_response["board"] == ["o", nil, nil, nil, "x", nil, nil, nil, nil]

    {:ok, state}
  end

  defp request_initialized_game_human_human(o_human, x_human) do
    request_initialized_game(o_human, "human", x_human, "human")
  end

  def request_initialized_game_computer_computer do
    request_initialized_game("R2-D2", "computer", "C-3PO", "computer")
  end

  defp request_initialized_game_human_computer(human_name, computer_name) do
    request_initialized_game(human_name, "human", "C-3PO", "computer")
  end

  defp request_initialized_game(o_name, o_type, x_name, x_type) do
    params = Poison.encode!(%{o_type: o_type, o_name: o_name, x_name: x_name, x_type: x_type})

    response = conn()
    |> content_type_json
    |> post("/initialize", params)

    decoded_response = json_response(response, 200)
    decoded_response["game_id"]
  end

  defp request_to_start_game(game_id, first_player) do
    params = Poison.encode!(%{first_player: first_player})

    conn()
    |> content_type_json
    |> post("/start/#{game_id}", params)
  end

  defp move(game_id) do
    conn()
    |> post("/move/#{game_id}")
  end

  defp content_type_json(conn) do
    put_req_header(conn, "content-type", "application/json")
  end
end