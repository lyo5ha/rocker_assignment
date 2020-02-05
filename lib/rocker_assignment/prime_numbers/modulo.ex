defmodule RockerAssignment.CheckPrime.Modulo do
  @moduledoc """
  Modulo for checking prime
  """

  def calculate(exponent, base, mod) do
    x = 1
    y = base
    loop_modulo(exponent, x, y, mod)
  end

  def loop_modulo(exponent, x, y, mod) do
    case exponent > 0 do
      true ->
        if Integer.mod(exponent, 2) == 1 do
          x = Integer.mod(x*y, mod)
        end
        exponent =  div(exponent, 2)
        loop_modulo(exponent, x, y, mod)
      _ -> Integer.mod(x, mod)
    end
  end
end
