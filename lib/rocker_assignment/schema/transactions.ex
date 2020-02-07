defmodule RockerAssignment.Schema.Transactions do
  @moduledoc """
  Transactions context. Methods for working with repo.
  """

  alias RockerAssignment.Repo
  alias RockerAssignment.Schema.{User, Loan}

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

  def update_loan(%Loan{} = loan, rate) do
    loan |> Repo.preload(:user)
    loan
    |> Repo.preload(:user)
    |> Loan.changeset(%{rate: rate, status: "ACCEPTED"})
    |> Repo.update()
  end

  def reject_loan(%Loan{} = loan) do
    loan
    |> Repo.preload(:user)
    |> Loan.changeset(%{status: "REJECTED"})
    |> Repo.update()
  end

  def get_user(%{email: email} = _params),  do: Repo.get_by(User, email: email)
end
