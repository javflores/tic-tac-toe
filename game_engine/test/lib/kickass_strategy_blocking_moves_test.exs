defmodule GameEngine.KickAssStrategyBlockingMovesTest do
	use ExUnit.Case
	alias GameEngine.PlayStrategies.KickAssStrategy, as: KickAssStrategy

	test "o is able to identify that x is the opponent" do
		player = :o
		oponent = KickAssStrategy.spot_opponent(player)

		expected_opponent = :x
		assert oponent == expected_opponent
	end

	test "x is able to identify that o is the opponent" do
		player = :x
		oponent = KickAssStrategy.spot_opponent(player)

		expected_opponent = :o
		assert oponent == expected_opponent
	end

	test "o blocks opponent by taking horizontal win for x" do
		horizontal_blocking = {:x, nil, :x,
							   nil, :o, nil,
						       nil, nil, nil}

		move = KickAssStrategy.calculate_move(%GameEngine.Board{positions: horizontal_blocking}, :o)
			
		assert move == %{row: 0, column: 1}
	end

	test "o blocks opponent by taking vertical win for x" do
		vertical_blocking = {:o, :x, :o,
							 nil, nil, nil,
						     nil, :x, nil}

		move = KickAssStrategy.calculate_move(%GameEngine.Board{positions: vertical_blocking}, :o)
			
		assert move == %{row: 1, column: 1}
	end

	test "o blocks opponent by taking diagonal win for x" do
		diagonal_blocking = {:o, :x, :x,
							 nil, nil, nil,
						     :x, nil, nil}

		move = KickAssStrategy.calculate_move(%GameEngine.Board{positions: diagonal_blocking}, :o)
			
		assert move == %{row: 1, column: 1}
	end
end