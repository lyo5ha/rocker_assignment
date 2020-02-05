defmodule RockerAssignment.Schema.Transactions do
  @moduledoc """
  Transactions context. Methods for working with repo.
  """

  alias RockerAssignment.Repo
  alias RockerAssignment.Schema.{User, Loan}
  import RockerAssignment.Utils.Debug

  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def create_loan(user, %{amount: amount}) do
    user
    |> Ecto.build_assoc(:loans, %{status: "NEW", amount: amount})
    |> Repo.insert()
  end

  def get_user(%{email: email} = _params),  do: Repo.get_by(User, email: email)

  def get_user(id),  do: Repo.get(User, id)

  def get_loan(id),  do: Repo.get(Loan, id)

end
