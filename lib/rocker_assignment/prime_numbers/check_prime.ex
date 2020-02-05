defmodule RockerAssignment.CheckPrime do
  @moduledoc """
  Module for checking if number is prime number or composite number.
  There is a implementation of Solovay–Strassen primality test,
  which is  probabilistic. Chance of wrong answer with 30 iterations
  will be 1 of 1073741824, which could be consider as sufficient.
  Running time will be O(k·log^3 n), k=30.
  """

  alias RockerAssignment.CheckPrime.{Jacobian, Modulo}

  def prime?(p, iterations) do
    cond do
      p < 2 -> false
      p !=2 and Integer.mod(p, 2) == 0 -> false
      true ->
        case Enum.each(1..iterations, fn -> inner_fn(p) end) do
          false -> false
          _ -> true
        end
    end
  end

  def inner_fn(p) do
    a = Enum.random(1..p)
    jacobian = Integer.mod(p + Jacobian.calculate(a, p, {:start}), p)
    mod = Modulo.calculate(a, (p-1)/2, p)
    if jacobian == 0 or mod != jacobian do
      false
    end
  end
end
