defmodule GameEngine.GameTest do
    use ExUnit.Case

    import Mock

    setup do
        {:ok, game} = GameEngine.Game.start_link
        {:ok, game: game}
    end

    test "new started game contains an id", %{game: game} do
        game_id = "38c5c34f-6d33-4618-bb5f-9a9f1890ff8d"
        with_mock GameEngine.GameIdGenerator, [new: fn() -> game_id end] do
            {:ok, new_game} = GameEngine.Game.start(game, %{o: :computer, x: :computer, first_player: :o})

            assert new_game[:game_id] == game_id
        end
    end

    test "returns an empty board when game starts", %{game: game} do
        {:ok, new_game} = GameEngine.Game.start(game, %{o: :computer, x: :computer, first_player: :o})

        assert new_game[:board] == %GameEngine.Board{}
    end

    test "returns players when game starts", %{game: game} do
        {:ok, new_game} = GameEngine.Game.start(game, %{o: :computer, x: :computer, first_player: :o})

        assert new_game[:o] == :computer
        assert new_game[:x] == :computer
    end

    test "returns next player as first player", %{game: game} do
        {:ok, new_game} = GameEngine.Game.start(game, %{o: :computer, x: :computer, first_player: :o})

        assert new_game[:next_player] == :o
    end

    test "returns computer_computer type of game if two players are computers", %{game: game} do
        {:ok, new_game} = GameEngine.Game.start(game, %{o: :computer, x: :computer, first_player: :o})

        assert new_game[:type] == :computer_computer
    end

    test "game can be human versus computer", %{game: game} do
        {:ok, new_game} = GameEngine.Game.start(game, %{o: :human, x: :computer, first_player: :o})

        assert new_game[:type] == :human_computer
    end

    test "game can be human versus human", %{game: game} do
        {:ok, new_game} = GameEngine.Game.start(game, %{o: :human, x: :human, first_player: :o})

        assert new_game[:type] == :human_human
    end

    test "providing computer and human player makes a human versus computer game", %{game: game} do
        {:ok, new_game} = GameEngine.Game.start(game, %{o: :computer, x: :human, first_player: :o})

        assert new_game[:type] == :human_computer
    end

    test "pass on information to player when starting game", %{game: game} do
        with_mock GameEngine.Player, [initialize: fn(_player, _type, _mark, _game_type) -> {:ok} end] do
            GameEngine.Game.start(game, %{o: :computer, x: :computer, first_player: :o})

            assert called GameEngine.Player.initialize(:_, :computer, :o, :computer_computer)
            assert called GameEngine.Player.initialize(:_, :computer, :x,:computer_computer)
        end
    end

    test "next player is told to perform a move with positions in the board", %{game: game} do
        with_mock GameEngine.Player, [:passthrough], [move: fn(_player, _board) -> {:ok, %GameEngine.Board{}} end] do
            next_player = :o
            game_id = start_new_game(game, next_player)

            GameEngine.Game.move(game, game_id)

            assert called GameEngine.Player.move(:o, %GameEngine.Board{})
        end
    end

    test "game returns which player moved", %{game: game} do
        with_mock GameEngine.Player, [:passthrough], [move: fn(_player, _board) -> {:ok, %GameEngine.Board{}} end] do
            first_player_to_move = :o
            game_id = start_new_game(game, first_player_to_move)

            {:ok, move} = GameEngine.Game.move(game, game_id)

            assert move[:player] == first_player_to_move
        end
    end

    test "game returns which player is next", %{game: game} do
        with_mock GameEngine.Player, [:passthrough], [move: fn(_player, _board) -> {:ok, %GameEngine.Board{}} end] do
            next_player_to_move = :x
            game_id = start_new_game(game, :o)

            {:ok, move} = GameEngine.Game.move(game, game_id)

            assert move[:next_player] == next_player_to_move
        end
    end

    test "game returns the board after player moves", %{game: game} do
        board_after_move = %GameEngine.Board{positions: {:o, nil, nil, nil, nil, nil, nil, nil, nil}}
        with_mock GameEngine.Player, [:passthrough], [move: fn(_player, _board) -> {:ok, board_after_move} end] do
            game_id = start_new_game(game, :o)

            {:ok, move} = GameEngine.Game.move(game, game_id)

            assert move[:board] == board_after_move
        end
    end

    test "check for winner upon player moves", %{game: game} do
        with_mock GameEngine.Board, [:passthrough], [resolve_winner: fn(_board) -> {:no_winner} end] do
            game_id = start_new_game(game, :o)
            {:ok, move} = GameEngine.Game.move(game, game_id)

            assert called GameEngine.Board.resolve_winner(:_)
        end
    end

    test "game status is winner if a player wins", %{game: game} do
        with_mock GameEngine.Board, [:passthrough], [resolve_winner: fn(_board) -> {:winner, :o} end] do
            game_id = start_new_game(game, :o)
            {:winner, move} = GameEngine.Game.move(game, game_id)

            assert move[:status] == :winner
        end
    end

    test "we have a winner", %{game: game} do
        with_mock GameEngine.Board, [:passthrough], [resolve_winner: fn(_board) -> {:winner, :o} end] do
            game_id = start_new_game(game, :o)
            {:winner, move} = GameEngine.Game.move(game, game_id)

            assert move[:winner] == :o
        end
    end

    test "game is a draw if the board is full", %{game: game} do
        with_mock GameEngine.Board, [:passthrough],
            [resolve_winner: fn(_board) -> {:no_winner} end, full?: fn(_board) -> true end] do

            game_id = start_new_game(game, :o)
            {:ok, move} = GameEngine.Game.move(game, game_id)

            assert move[:status] == :draw
        end
    end

    test "game is in progress if no draw nor a winner", %{game: game} do
        with_mock GameEngine.Board, [:passthrough],
            [resolve_winner: fn(_board) -> {:no_winner} end, full?: fn(_board) -> false end] do

            game_id = start_new_game(game, :o)
            {:ok, move} = GameEngine.Game.move(game, game_id)

            assert move[:status] == :in_progress
        end
    end

    test "passing human move to player", %{game: game} do
        with_mock GameEngine.Player, [:passthrough], [move: fn(_player, _board, _move) -> {:ok, %GameEngine.Board{}} end] do
            game_id = start_new_game(game, :human, :computer, :o)

            human_move = %{row: 0, column: 0}
            {:ok, move} = GameEngine.Game.move(game, game_id, human_move)

            assert called GameEngine.Player.move(:o, %GameEngine.Board{}, human_move)
        end
    end

    defp start_new_game(game, o, x, first_player) do
        {:ok, new_game} = GameEngine.Game.start(game, %{o: o, x: x, first_player: first_player})

        new_game[:game_id]
    end

    defp start_new_game(game, first_player) do
        start_new_game(game, :computer, :computer, first_player)
    end
end
