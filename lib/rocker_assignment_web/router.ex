defmodule RockerAssignmentWeb.Router do
  use RockerAssignmentWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RockerAssignmentWeb do
    scope "/v1" do
      scope "/loan" do
        pipe_through :api

        post "new",  LoanApplicationController, :new
        get  "all",  LoanApplicationController, :all
      end
    end
  end
end
