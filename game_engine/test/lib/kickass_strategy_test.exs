defmodule GameEngine.KickAssStrategyTest do
	use ExUnit.Case

	@player :o
	@opponent :x

	test "kickass strategy finds immediate victory" do
		board = %GameEngine.Board{positions: {@player, @player, nil,
						 					  nil, nil, nil,
						 					  @opponent, @opponent, nil}}

		victory = GameEngine.PlayStrategies.KickAssStrategy.calculate_move(board, @player)
			
		assert victory == %{row: 0, column: 2}
	end

	test "kickass strategy tells to block immediate victory of opponent" do
		board = %GameEngine.Board{positions: {@opponent, @opponent, nil,
						 					  nil, nil, nil,
						 					  nil, @player, nil}}

		block = GameEngine.PlayStrategies.KickAssStrategy.calculate_move(board, @player)
			
		assert block == %{row: 0, column: 2}
	end

	test "kickass strategy finds a fork in order have two threats to win" do
		board = %GameEngine.Board{positions: {@player, @opponent, nil,
						 					  nil, @player, nil,
						 					  nil, nil, @opponent}}

		fork = GameEngine.PlayStrategies.KickAssStrategy.calculate_move(board, @player)
			
		assert fork == %{row: 1, column: 0}
	end

	test "kickass strategy prevents fork by opponent" do
		board = %GameEngine.Board{positions: {@player, nil, nil,
						 					  nil, @opponent, nil,
						 					  nil, nil, @opponent}}

		prevent_fork = GameEngine.PlayStrategies.KickAssStrategy.calculate_move(board, @player)
			
		assert prevent_fork == %{row: 2, column: 0}
	end

	test "kickass strategy tells to block a possible fork by opponent" do
		board = %GameEngine.Board{positions: {@opponent, @player, nil,
						 					  nil, @opponent, nil,
						 					  nil, nil, @player}}

		block_opponents_fork = GameEngine.PlayStrategies.KickAssStrategy.calculate_move(board, @player)
			
		assert block_opponents_fork == %{row: 2, column: 0}
	end

	test "kickass strategy finds a position to force opponent into defending to create a later fork" do
		board = %GameEngine.Board{positions: {nil, @opponent, nil,
						 					  nil, @player, nil,
						 					  nil, nil, nil}}

		force_defending = GameEngine.PlayStrategies.KickAssStrategy.calculate_move(board, @player)
			
		assert force_defending == %{row: 0, column: 0}
	end

	test "kickass strategy finds center as next move" do
		board = %GameEngine.Board{positions: {nil, nil, nil,
						 					  nil, nil, nil,
						 					  nil, nil, nil}}

		move = GameEngine.PlayStrategies.KickAssStrategy.calculate_move(board, @player)
			
		assert move == %{row: 1, column: 1}
	end

	test "kickass strategy finds corner opposite to opponents corner" do
		board = %GameEngine.Board{positions: {nil, @opponent, @player,
						 					  nil, @player, nil,
						 					  @opponent, @player, @opponent}}

		move = GameEngine.PlayStrategies.KickAssStrategy.calculate_move(board, @player)
			
		assert move == %{row: 0, column: 0}
	end

	test "kickass strategy finds empty corner" do
		board = %GameEngine.Board{positions: {nil, @opponent, @player,
						 					  nil, @player, @opponent,
						 					  @opponent, @player, @opponent}}

		move = GameEngine.PlayStrategies.KickAssStrategy.calculate_move(board, @player)
			
		assert move == %{row: 0, column: 0}
	end

	test "kickass strategy finds empty side" do
		board = %GameEngine.Board{positions: {@opponent, @opponent, @player,
						 					  nil, @player, @opponent,
						 					  @opponent, @player, @opponent}}

		move = GameEngine.PlayStrategies.KickAssStrategy.calculate_move(board, @player)
			
		assert move == %{row: 1, column: 0}
	end
end
