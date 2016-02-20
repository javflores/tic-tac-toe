defmodule GameEngine.ConnCase do

  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ConnTest

      import GameEngine.Router.Helpers

      @endpoint GameEngine.Endpoint
    end
  end

  setup(_tags) do
    {:ok, conn: Phoenix.ConnTest.conn()}
  end
end
