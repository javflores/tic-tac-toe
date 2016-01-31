defmodule GameEngine.Features.HumanVersusComputerGameContext do
    use WhiteBread.Context
    use Phoenix.ConnTest

    @endpoint GameEngine.Endpoint

    given_ ~r/^I have started a human versus computer game$/, fn state ->
        IO.puts "Hello"
        game_id = request_initialized_game("Johny", "C-3PO")
        IO.inspect game_id
        
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

    defp request_initialized_game(human_name, computer_name) do
        params = Poison.encode!(%{o_type: "human", o_name: human_name, x_name: computer_name, x_type: "computer"})

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

    defp content_type_json(conn) do
        put_req_header(conn, "content-type", "application/json")
    end
end