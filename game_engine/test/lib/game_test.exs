defmodule GameEngine.GameTest do
	use ExUnit.Case

	import Mock

	setup do
		{:ok, game} = GameEngine.Game.start_link
		{:ok, game: game}
	end

	test "returns a new game when initializing", %{game: game} do
		{:ok, new_game} = GameEngine.Game.initialize(game, :computer_computer, "R2-D2", "C-3PO")

		assert new_game[:board] == %{}
		assert new_game[:o] == "R2-D2"
		assert new_game[:x] == "C-3PO"
	end

	test "new initialized game contains an id", %{game: game} do
		game_id = "38c5c34f-6d33-4618-bb5f-9a9f1890ff8d"
		with_mock GameEngine.GameIdGenerator, [new: fn() -> game_id end] do
			{:ok, new_game} = GameEngine.Game.initialize(game, :computer_computer, "R2-D2", "C-3PO")

			assert new_game[:game_id] == game_id
		end
	end

	test "receive error if game to start is not the initialized game", %{game: game} do
		GameEngine.Game.initialize(game, :computer_computer, "R2-D2", "C-3PO")
		different_game_id = 12;

		{:error, error} = GameEngine.Game.start(game, different_game_id, "R2-D2")

		assert error == "Invalid game_id provided"
	end

	test "pass on information to player when initializing", %{game: game} do
		with_mock GameEngine.Player, [initialize: fn(_player, _name, _mark, _game_type) -> {:ok} end] do
			GameEngine.Game.initialize(game, :computer_computer, "R2-D2", "C-3PO")

			assert called GameEngine.Player.initialize(:_, "R2-D2", :o, :computer_computer)
			assert called GameEngine.Player.initialize(:_, "C-3PO", :x, :computer_computer)
		end
	end

	test "get an empty board when starting game", %{game: game} do
		{:ok, new_game} = GameEngine.Game.initialize(game, :computer_computer, "R2-D2", "C-3PO")
		
		{:ok, game} = GameEngine.Game.start(game, new_game[:game_id], "R2-D2")

		assert game[:board] == %GameEngine.Board{}
	end

	test "assign first player when game starts", %{game: game} do
		{:ok, new_game} = GameEngine.Game.initialize(game, :computer_computer, "R2-D2", "C-3PO")
		
		first_player = "R2-D2"
		{:ok, game} = GameEngine.Game.start(game, new_game[:game_id], first_player)

		assert game[:next_player] == :o
	end

	test "receive error when the provided first player is not part of the game", %{game: game} do
		{:ok, new_game} = GameEngine.Game.initialize(game, :computer_computer, "R2-D2", "C-3PO")
		
		player_not_part_of_game = "Intruder"
		{:error, error} = GameEngine.Game.start(game, new_game[:game_id], player_not_part_of_game)

		assert error == "Invalid first player provided, not part of the game"
	end

	test "next player is told to perform a move with positions in the board", %{game: game} do
		with_mock GameEngine.Player, [:passthrough], [move: fn(_player, _board) -> {:ok, %GameEngine.Board{}} end] do
			next_player = "R2-D2"
			game_id = start_new_game(game, "R2-D2", "C-3PO", next_player)

			GameEngine.Game.move(game, game_id)

			assert called GameEngine.Player.move(:o, %GameEngine.Board{})
		end
	end

	test "game returns which player moved", %{game: game} do
		with_mock GameEngine.Player, [:passthrough], [move: fn(_player, _board) -> {:ok, %GameEngine.Board{}} end] do
			first_player_to_move = "R2-D2"
			game_id = start_new_game(game, "R2-D2", "C-3PO", first_player_to_move)

			{:ok, move} = GameEngine.Game.move(game, game_id)

			assert move[:player] == first_player_to_move
		end
	end

	test "game returns which player is next", %{game: game} do
		with_mock GameEngine.Player, [:passthrough], [move: fn(_player, _board) -> {:ok, %GameEngine.Board{}} end] do
			next_player_to_move = "C-3PO"
			game_id = start_new_game(game, "R2-D2", next_player_to_move, "R2-D2")

			{:ok, move} = GameEngine.Game.move(game, game_id)

			assert move[:next_player] == next_player_to_move
		end
	end

	test "game returns the board after player moves", %{game: game} do
		board_after_move = %GameEngine.Board{positions: {:o, nil, nil, nil, nil, nil, nil, nil, nil}}		
		with_mock GameEngine.Player, [:passthrough], [move: fn(_player, _board) -> {:ok, board_after_move} end] do
			game_id = start_new_game(game, "R2-D2", "C-3PO", "R2-D2")

			{:ok, move} = GameEngine.Game.move(game, game_id)

			assert move[:board] == board_after_move
		end
	end

	test "check for winner upon player moves", %{game: game} do
		with_mock GameEngine.Board, [:passthrough], [resolve_winner: fn(_board) -> {:no_winner} end] do
			game_id = start_new_game(game, "R2-D2", "C-3PO", "R2-D2")
			{:ok, move} = GameEngine.Game.move(game, game_id)

			assert called GameEngine.Board.resolve_winner(:_)
		end
	end

	test "game status is winner if a player wins", %{game: game} do
		with_mock GameEngine.Board, [:passthrough], [resolve_winner: fn(_board) -> {:winner, :o} end] do
			game_id = start_new_game(game, "R2-D2", "C-3PO", "R2-D2")
			{:winner, move} = GameEngine.Game.move(game, game_id)

			assert move[:status] == :winner
		end
	end

	test "we have a winner", %{game: game} do
		with_mock GameEngine.Board, [:passthrough], [resolve_winner: fn(_board) -> {:winner, :o} end] do
			game_id = start_new_game(game, "R2-D2", "C-3PO", "R2-D2")
			{:winner, move} = GameEngine.Game.move(game, game_id)

			assert move[:winner] == "R2-D2"
		end
	end

	test "game is a draw if the board is full", %{game: game} do
        with_mock GameEngine.Board, [:passthrough], 
        	[resolve_winner: fn(_board) -> {:no_winner} end,
        	 full?: fn(_board) -> true end] do

			game_id = start_new_game(game, "R2-D2", "C-3PO", "R2-D2")
			{:ok, move} = GameEngine.Game.move(game, game_id)

			assert move[:status] == :draw
		end
	end

	test "game is in progress if no draw nor a winner", %{game: game} do
		with_mock GameEngine.Board, [:passthrough], 
        	[resolve_winner: fn(_board) -> {:no_winner} end,
        	 full?: fn(_board) -> false end] do

			game_id = start_new_game(game, "R2-D2", "C-3PO", "R2-D2")
			{:ok, move} = GameEngine.Game.move(game, game_id)

			assert move[:status] == :in_progress
		end
	end

	defp start_new_game(game, o, x, first_player) do
		{:ok, new_game} = GameEngine.Game.initialize(game, :computer_computer, o, x)
		GameEngine.Game.start(game, new_game[:game_id], first_player)

		new_game[:game_id]
	end
end