defmodule RockerAssignment.Repo do
  use Ecto.Repo,
    otp_app: :rocker_assignment,
    adapter: Ecto.Adapters.Postgres
end
