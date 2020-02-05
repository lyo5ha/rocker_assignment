defmodule RockerAssignment.CreditRegulation do
  @moduledoc """
  Module which implement logic for loan issuing.
  Covers following requirements:
  1. If a loan application has a lower “Requested loan amount” than any
   of the previous loan applications, then the loan is rejected.

  2. If a loan application has a Requested loan amount which is a prime
  number, then a loan offer is granted with interest rate of 9.99%

  3. Otherwise, a loan is offered with random interest rate between 4%
  and 12%.
  """

  import RockerAssignment.Utils.Debug

  def apply(%{amount: amount} = loan) do
    with {:ok, rate}          <- AmountServer.check(amount),
         {:ok, rate}          <- PrimeNumbers.check(amount),
         {:ok, updated_loan}  <- Transactions.update_loan(loan, rate) do
      {:ok, updated_loan}
    else
      {:error, error} ->
        logger(error, "from apply")
    end
  end
end
