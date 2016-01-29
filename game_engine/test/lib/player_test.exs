defmodule GameEngine.PlayerTest do
	use ExUnit.Case

	import Mock

	setup do
		{:ok, player} = GameEngine.Player.start_link
		{:ok, player: player}
	end

	test "player assigns his name", %{player: player} do
		{:ok, player_initialization} = GameEngine.Player.initialize(player, "R2-D2", :computer, :o, :computer_computer)

		assert player_initialization[:name] == "R2-D2"
	end

	test "player assigns his type", %{player: player} do
		{:ok, player_initialization} = GameEngine.Player.initialize(player, "R2-D2", :computer, :o, :computer_computer)

		assert player_initialization[:type] == :computer
	end

	test "player assigns his mark", %{player: player} do
		{:ok, player_initialization} = GameEngine.Player.initialize(player, "R2-D2", :computer, :o, :computer_computer)

		assert player_initialization[:mark] == :o
	end

	test "player will play simple if two computers are going to play", %{player: player} do
		{:ok, player_initialization} = GameEngine.Player.initialize(player, "R2-D2", :computer, :o, :computer_computer)

		assert player_initialization[:strategy] == :simple
	end

	test "computer will play a kickass strategy if playing with a human", %{player: player} do
		{:ok, player_initialization} = GameEngine.Player.initialize(player, "R2-D2", :computer, :o, :human_computer)

		assert player_initialization[:strategy] == :kickass
	end

	test "human player has a human behaviour", %{player: player} do
		{:ok, player_initialization} = GameEngine.Player.initialize(player, "Johny", :human, :o, :human_computer)

		assert player_initialization[:strategy] == :human
	end

	test "computer player plays simple against another computer", %{player: player} do
		played_position = %{row: 1, column: 2}
		with_mock GameEngine.SimpleStrategy, [calculate_move: fn(_board) -> played_position end] do

			GameEngine.Player.initialize(player, "R2-D2", :computer, :o, :computer_computer)

			{:ok, board} = GameEngine.Player.move(player, %GameEngine.Board{})

			assert GameEngine.Board.get_by_position(board, %{row: 1, column: 2}) == :o
		end
	end
end