defmodule RockerAssignmentWeb.Router do
  use RockerAssignmentWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RockerAssignmentWeb do
    pipe_through :api
  end
end
