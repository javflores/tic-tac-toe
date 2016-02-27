defmodule GameEngine.GameTest do
    use ExUnit.Case

    import Mock

    @empty_board [nil, nil, nil, nil, nil, nil, nil, nil, nil]

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

        assert new_game[:board] == @empty_board
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

    test "next player is told to perform a move with positions in the board", %{game: game} do
        with_mock GameEngine.Player, [:passthrough], [move: fn(_board, _player) -> @empty_board end] do
            next_player = :o
            game_id = start_new_game(game, next_player)

            GameEngine.Game.move(game, game_id)

            assert called GameEngine.Player.move(@empty_board, :o)
        end
    end

    test "game returns which player moved", %{game: game} do
        with_mock GameEngine.Player, [:passthrough], [move: fn(_board, _player) -> @empty_board end] do
            first_player_to_move = :o
            game_id = start_new_game(game, first_player_to_move)

            {:ok, move} = GameEngine.Game.move(game, game_id)

            assert move[:player] == first_player_to_move
        end
    end

    test "game returns which player is next", %{game: game} do
        with_mock GameEngine.Player, [:passthrough], [move: fn(_board, _player) -> @empty_board end] do
            first_player = :o
            game_id = start_new_game(game, first_player)

            {:ok, move} = GameEngine.Game.move(game, game_id)

            assert move[:next_player] == :x
        end
    end

    test "game returns the board after player moves", %{game: game} do
        board_after_move = {:o, nil, nil, nil, nil, nil, nil, nil, nil}
        with_mock GameEngine.Player, [:passthrough], [move: fn(_board, _player) -> board_after_move end] do
            game_id = start_new_game(game, :o)

            {:ok, move} = GameEngine.Game.move(game, game_id)

            assert move[:board] == board_after_move
        end
    end

    test "game status is winner if a player wins", %{game: game} do
        with_mock GameEngine.Player, [:passthrough], [move: fn(_board, _player) -> {:o, :o, :o, :x, :x, :o, :o, :x, :o} end] do
            game_id = start_new_game(game, :o)
            {:ok, move} = GameEngine.Game.move(game, game_id)

            assert move[:status] == :winner
        end
    end

    test "game is a draw", %{game: game} do
        with_mock GameEngine.Player, [:passthrough], [move: fn(_board, _player) -> {:o, :x, :x, :x, :o, :o, :x, :o, :x} end] do
            game_id = start_new_game(game, :o)
            {:ok, move} = GameEngine.Game.move(game, game_id)

            assert move[:status] == :draw
        end
    end

    test "game is in progress if no draw nor a winner", %{game: game} do
        with_mock GameEngine.Player, [:passthrough], [move: fn(_board, _player) -> {:o, nil, nil, nil, nil, nil, nil, nil, nil} end] do

            game_id = start_new_game(game, :o)
            {:ok, move} = GameEngine.Game.move(game, game_id)

            assert move[:status] == :in_progress
        end
    end

    test "passing position to player", %{game: game} do
        with_mock GameEngine.Player, [:passthrough], [move: fn(_board, _position, _player) -> @empty_board end] do
            game_id = start_new_game(game, :human, :computer, :o)

            position = %{row: 0, column: 0}
            {:ok, move} = GameEngine.Game.move(game, game_id, position)

            assert called GameEngine.Player.move(@empty_board, position, :o)
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
