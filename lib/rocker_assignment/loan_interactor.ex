defmodule RockerAssignment.LoanInteractor do
  @moduledoc """
  Interactor for loan creation.
  """
  alias RockerAssignment.Schema.Transactions
  alias RockerAssignment.CreditRegulation

  import RockerAssignment.Utils.Debug

  def new_loan(params) do
    map = parse_params(params)
    with {:ok, user}            <- get_user(map),
         {:ok, loan}            <- Transactions.create_loan(user, map),
         {:ok, processed_loan}  <- CreditRegulation.apply(loan),
         {:ok, response_params} <- serialize_response(processed_loan) do
      {:ok, response_params}
    else
      {:error, error} ->
        {:error, error}
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
      false -> {:error, {:message, "Name is not valid for existing email"}}
    end
  end


  def send_all_loans(conn) do
    with {:ok, loans} <- Transactions.get_all_loans,
         {:ok, json} <- serialize_response_all(loans) do
      send_response(conn, json)
    else
      {:error, error} ->
        logger(error, "error form send_all_loans")
      {:error, error}
    end
  end

    def send_response(conn, json) do
      conn
      |> Plug.Conn.put_resp_header("content-type", "application/json; charset=utf-8")
      |> Plug.Conn.send_resp(200, json)
    end


  defp parse_params(params) do
    %{
        amount: params["data"]["amount"],
        name:   params["data"]["user"]["name"],
        email:  params["data"]["user"]["email"],
        phone:  params["data"]["user"]["phone"]
      }
  end

  defp serialize_response({:ok, loan} = _params) do
    %{
        jsonapi: %{version: "1.0"},
        data: %{
          type: "loan",
          id: loan.id,
          status: loan.status,
          rate: nil
        }
      }
    |> Jason.encode
  end
  defp serialize_response(params) do
    %{
        jsonapi: %{version: "1.0"},
        data: %{
          type: "loan",
          id: params.id,
          status: params.status,
          rate: params.rate/100
        }
      }
    |> Jason.encode
  end

  defp serialize_response_all(loans) do
    loan_list = Enum.map(loans, fn(x) -> form_loans_list(x) end)
    json = Jason.encode!(loan_list)
    logger(json, "json from serialize response_all")
    {:ok, json}
  end

  def form_loans_list(loan) do
    rate =
      case loan.rate do
        nil -> nil
        _ -> loan.rate/100
      end
    # logger(loan, "loan form form_loans_list")
    %{
      data: %{
        type: "loan",
        amount: loan.amount,
        id: loan.id,
        user: %{
          name: loan.user.name,
          phone: loan.user.phone,
          email: loan.user.email
        },
        status: loan.status,
        rate: rate
      }
    }
  end
end
