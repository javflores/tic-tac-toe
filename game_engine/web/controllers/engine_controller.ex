defmodule GameEngine.EngineController do
    use GameEngine.Web, :controller

    def preflight(conn, _params) do
        conn
        |> send_resp(200, "")
    end

    def start(conn, params) do
        case GameEngine.Game.start(:game, get_players(params)) do
            {:ok, game} ->
                conn
                |> json(handle_response(:start, game))

            {:error, message} ->
                conn
                |> put_status(400)
                |> json(message)
        end
    end

    def move(conn, %{"game_id" => game_id, "move" => %{"row" => row, "column" => column}}) do
      {:ok, move} = GameEngine.Game.move(:game, game_id, %{row: row, column: column})

      conn
      |> json(handle_response(:move, game_id, move))
    end

    def move(conn, %{"game_id" => game_id}) do
        {:ok, move} = GameEngine.Game.move(:game, game_id)

        conn
        |> json(handle_response(:move, game_id, move))
    end

    defp handle_response(:start, %{game_id: game_id, board: board, o: o, x: x, type: type, next_player: next_player}) do
        %{game_id: game_id,
          status: :start,
          type: type,
          o: o,
          x: x,
          board: Tuple.to_list(board.positions),
          next_player: parse_player(next_player)}
    end

    defp handle_response(:move, game_id, %{status: status, board: board, player: player, next_player: next_player}) do
        %{game_id: game_id,
          status: status,
          player: parse_player(player),
          board: Tuple.to_list(board.positions),
          next_player: parse_player(next_player)}
    end

    defp get_players(params) do
        o = params["o"]
        x = params["x"]
        first_player = params["first_player"]

        %{o: String.to_atom(o), x: String.to_atom(x), first_player: String.downcase(first_player) |> String.to_atom }
    end

    defp parse_player(player), do: Atom.to_string(player) |> String.capitalize
end
