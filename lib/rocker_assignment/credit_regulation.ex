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
  alias RockerAssignment.Schema.Transactions
  alias RockerAssignment.CheckPrime

  def apply(%{amount: amount} = loan) do
    with {:ok, confirmed_amount}  <- amount_check(amount, loan),
         {:ok, rate}              <- prime_check(confirmed_amount),
         {:ok, updated_loan}      <- Transactions.update_loan(loan, rate) do
      {:ok, updated_loan}
    else
      {:error, loan} ->
        rejected_loan = Transactions.reject_loan(loan)
        {:ok, rejected_loan}
    end
  end

  defp amount_check(amount, loan) do
    cond do
      GenServer.call({:global, :amount_server}, :get) < amount ->
        GenServer.cast({:global, :amount_server}, {:put, amount})
        {:ok, amount}
      true -> {:error, loan}
    end
  end

  defp prime_check(amount) do
    case CheckPrime.prime?(amount) do
      true   -> {:ok, 999}
      false  -> {:ok, Enum.random(400..1200)}
    end
  end
end
