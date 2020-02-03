defmodule DocTest do
  use ExUnit.Case

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(RockerAssignment.Repo)
  end


  doctest RockerAssignment.Schema.Transactions
end
