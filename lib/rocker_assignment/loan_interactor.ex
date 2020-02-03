defmodule RockerAssignment.LoanInteractor do
  @moduledoc """
  Interactor for loan creation.
  """
  import RockerAssignment.Utils.Debug
  alias RockerAssignment.Schema.{User, Loan, Transactions}

  def new_loan(params) do
    %{
        name:   params["data"]["user"]["name"],
        email:  params["data"]["user"]["email"],
        phone:  params["data"]["user"]["phone"]
      }
      |> Transactions.create_user
  end

  def send_response(params) do
    logger(params, "params from send_response")
  end
end
