defmodule RockerAssignmentWeb.LoanApplicationController do
  use RockerAssignmentWeb, :controller
  alias RockerAssignment.Utils.{Validate, ErrorResolver}
  alias RockerAssignment.LoanInteractor
  import RockerAssignment.Utils.Debug


  @moduledoc """
  Main controller for loan applications
  """

  def new(conn, params) do
    with {:ok, valid_params}  <- Validate.params(params),
         {:ok, valid_loan}    <- LoanInteractor.new_loan(valid_params) do
      conn |> LoanInteractor.send_response(valid_loan)
    else
      {:error, error_params} ->
        conn |> ErrorResolver.call(error_params)
    end
  end

  # def all(conn, _params) do
  # end
end
