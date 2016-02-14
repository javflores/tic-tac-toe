defmodule GameEngine.PlayStrategies.Moves.OpponentsForksBlockerTest do
	use ExUnit.Case
	alias GameEngine.PlayStrategies.Moves.OpponentsForksBlocker, as: OpponentsForksBlocker

	@player :o
	@opponent :x

	test "takes out moves leading to opponents fork" do
		positions = {@opponent, nil, nil,
					 nil, @player, nil,
					 nil, nil, @opponent}
		possible_move = %{row: 0, column: 2}
		list_of_moves = [possible_move]

		safe_moves = OpponentsForksBlocker.reject(list_of_moves, %GameEngine.Board{positions: positions}, @player)

		assert safe_moves == []
	end

	test "refutes unsafe defence leading to opponent fork" do
		board = %GameEngine.Board{positions: {@opponent, nil, nil,
					 						  nil, @player, nil,
					 						  nil, nil, @opponent}}
		move = %{row: 0, column: 2}

		refute OpponentsForksBlocker.is_safe_defence?(move, board, @player)
	end

	test "refutes unsafe defence when opponent starts" do
		board = %GameEngine.Board{positions: {@player, nil, nil,
					 						  nil, @opponent, nil,
					 						  nil, nil, @opponent}}
		move = %{row: 0, column: 1}

		refute OpponentsForksBlocker.is_safe_defence?(move, board, @player)
	end

	test "finds safe defence" do
		board = %GameEngine.Board{positions: {@player, nil, nil,
					 						  nil, @opponent, nil,
					 						  nil, nil, @opponent}}
		move = %{row: 0, column: 2}

		assert OpponentsForksBlocker.is_safe_defence?(move, board, @player)
	end
end
