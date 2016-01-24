defmodule GameEngine.EngineController do
	use GameEngine.Web, :controller

	def initialize(conn, params) do
		type = params["type"]

		{:ok, new_game} = GameEngine.Engine.initialize(:engine, type)
		
		conn
		|> json(handle_response(:init, type, new_game))
	end

	defp handle_response(status, type, game) do
		%{status: status,
		  type: type,
		  game: game}
	end
end