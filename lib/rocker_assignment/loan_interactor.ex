defmodule RockerAssignment.LoanInteractor do
  @moduledoc """
  Interactor for loan creation.
  """
  import RockerAssignment.Utils.Debug
  alias RockerAssignment.Schema.{User, Loan, Transactions}
  alias RockerAssignment.CreditRegulation

  def new_loan(params) do
    map = parse_params(params)
    valid_loan = %{some: "loan_infirmation"}
    with {:ok, user}            <- get_user(map),
         {:ok, loan}            <- Transactions.create_loan(user, map),
         {:ok, processed_loan}  <- CreditRegulation.apply(loan),
         {:ok, response_params} <- serialize_response(processed_loan) do
      {:ok, response_params}
    else
      {:error, error} ->
        logger(error, "error from new loan")
    end
  end

  defp get_user(map) do
    case Transactions.get_user(map) do
      nil  -> Transactions.create_user(map)
      user -> check_name(user, map)
    end
  end

  defp check_name(%{name: saved_name} = user, %{name: params_name}) do
    case saved_name == params_name do
      true  -> {:ok, user}
      false -> {:error, "Name is not valid for existing email"}
    end
  end

  defp parse_params(params) do
    %{
        amount: params["data"]["amount"],
        name:   params["data"]["user"]["name"],
        email:  params["data"]["user"]["email"],
        phone:  params["data"]["user"]["phone"]
      }
  end

  defp serialize_response(loan) do
    logger(loan, "loan form serialize response")
  end

  def send_response(params) do
    logger(params, "params from send_response")
  end
end
