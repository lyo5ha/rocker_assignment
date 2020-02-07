defmodule RockerAssignmentWeb.LoanApplicationController do
  use RockerAssignmentWeb, :controller
  alias RockerAssignment.Utils.ErrorResolver
  alias RockerAssignment.LoanInteractor
  import RockerAssignment.Utils.Debug


  @moduledoc """
  Main controller for loan applications
  """

  def new(conn, params) do
    case LoanInteractor.new_loan(params) do
      {:ok, valid_params}     -> conn |> LoanInteractor.send_response(valid_params)
      {:error, error_params}  -> conn |> ErrorResolver.call(error_params)
    end
  end

  def all(conn, _params) do
    LoanInteractor.send_all_loans(conn)
  end
end
