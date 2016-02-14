defmodule GameEngine.PlayStrategies.Move do
  @callback find(GameEngine.Board, Atom) :: Map
end