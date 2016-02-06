defmodule GameEngine.AllowCrossDomainRequestsPlug do
	import Plug.Conn

	@allow_cross_origin "access-control-allow-origin"
	@allow_headers "access-control-allow-headers"
	@allow_methods "access-control-allow-methods"

	
	def init(options), do: options

 	def call(conn, _options) do
 		conn = conn 
 		|> put_resp_header(@allow_cross_origin, "*")
 		|> put_resp_header(@allow_headers, "content-type, access-control-allow-headers, authorization, x-requested-with")
 		|> put_resp_header(@allow_methods, "get, post, put, delete, options")

 		conn
 	end
end