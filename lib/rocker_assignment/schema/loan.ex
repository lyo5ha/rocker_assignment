defmodule RockerAssignment.Schema.Loan do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias RockerAssignment.Schema.Loan

  schema "loans" do
    field  :status, :string
    field  :amount, :integer
    field  :rate,   :integer

    timestamps()
    belongs_to :user, RockerAssignment.Schema.User
  end

  def changeset(%Loan{} = loan, attrs) do
    loan
    |> cast(attrs, ~w(status amount rate)a)
    |> validate_required(~w(status amount))
  end
end
