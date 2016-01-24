defmodule GameEngine.GameIdGenerator do
	def new do
		UUID.uuid1()
	end
end