defmodule RockerAssignment.CheckPrime do
  @moduledoc """
  Module for checking if number is prime number or composite number.
  There is a implementation of Solovay–Strassen primality test,
  which is  probabilistic. Chance of wrong answer with 30 iterations
  will be 1 of 1073741824, which could be considered as sufficient.
  Running time will be O(k·log^3 n), k=30.
  """
  import RockerAssignment.Utils.Debug
  alias RockerAssignment.CheckPrime.{Jacobian, Modulo}

  def prime?(p, iterations \\ 30) do
    a =
    cond do
      p < 2 -> false
      p !=2 and Integer.mod(p, 2) == 0 -> false
      true -> :ok
    end
    case a do
      false -> false
      :ok -> loop_fn(p, iterations)
    end
  end


  defp loop_fn(p, iterations) do
    case iterations do
      0 -> true
      _ ->
        case iterator_fn(p) do
          false -> false
          :ok ->
            iterations = iterations - 1
            loop_fn(p, iterations)
        end
    end
  end

  defp iterator_fn(p) do
    a = Enum.random(1..p)
    jacobian = Integer.mod(p + Jacobian.calculate(a, p), p)
    mod = Modulo.calculate(a, trunc((p-1)/2), p)
    cond do
      jacobian == 0 or mod != jacobian -> false
      true -> :ok
    end
  end
end
