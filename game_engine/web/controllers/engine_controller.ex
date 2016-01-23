defmodule GameEngine.EngineController do
	use GameEngine.Web, :controller

	def initiate(conn, params) do
		type = params["Type"]

		conn
		|> json(handle_response("init", type))
	end

	defp handle_response(status, type) do
		%{Status: status,
		  Type: type}
	end
end