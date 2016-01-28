defmodule GameEngine.PlayerTest do
	use ExUnit.Case

	import Mock

	setup do
		{:ok, player} = GameEngine.Player.start_link
		{:ok, player: player}
	end

	test "player assigns his name", %{player: player} do
		{:ok, player_initialization} = GameEngine.Player.initialize(player, "R2-D2", :o, :computer_computer)

		assert player_initialization[:name] == "R2-D2"
	end

	test "player assigns his mark", %{player: player} do
		{:ok, player_initialization} = GameEngine.Player.initialize(player, "R2-D2", :o, :computer_computer)

		assert player_initialization[:mark] == :o
	end

	test "player will play simple if two computers are going to play", %{player: player} do
		{:ok, player_initialization} = GameEngine.Player.initialize(player, "R2-D2", :o, :computer_computer)

		assert player_initialization[:strategy] == :simple
	end

	test "player playes simple", %{player: player} do
		played_position = %{row: 1, column: 2}
		with_mock GameEngine.SimpleStrategy, [calculate_move: fn(_board) -> played_position end] do

			GameEngine.Player.initialize(player, "R2-D2", :o, :computer_computer)

			{:ok, board} = GameEngine.Player.move(player, %GameEngine.Board{})

			assert GameEngine.Board.get_by_position(board, %{row: 1, column: 2}) == :o
		end
	end
end