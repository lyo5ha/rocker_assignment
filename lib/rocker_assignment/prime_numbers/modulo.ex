defmodule RockerAssignment.CheckPrime.Modulo do
  @moduledoc """
  Modulo for checking prime
  """

  import RockerAssignment.Utils.Debug

  def calculate(base, exponent, mod) do
    pid = start_state(exponent, base)
    loop_modulo(mod, pid)
  end

  def loop_modulo(mod, pid) do
    case get_exp(pid) > 0 do
      true ->
        if Integer.mod(get_exp(pid), 2) == 1 do
          Integer.mod(get_x(pid) * get_y(pid), mod) |> put_x(pid)
        end
        Integer.mod(get_y(pid) * get_y(pid), mod) |> put_y(pid)
        div(get_exp(pid), 2) |> put_exp(pid)
        loop_modulo(mod, pid)
      _ ->
        result = Integer.mod(get_x(pid), mod)
        stop_state(pid)
        result
    end
  end

  #state magagement

  defp start_state(exp, y) do
    {:ok, pid} = Agent.start_link(fn() -> %{exp: exp, x: 1, y: y} end)
    pid
  end
  defp put_x(x, pid) do
    Agent.update(pid, fn(map) -> Map.put(map, :x, x) end)
  end
  defp get_x(pid) do
    Agent.get(pid, fn(map) -> Map.get(map, :x) end)
  end
  defp put_y(y, pid) do
    Agent.update(pid, fn(map) -> Map.put(map, :y, y) end)
  end
  defp get_y(pid) do
    Agent.get(pid, fn(map) -> Map.get(map, :y) end)
  end
  defp put_exp(exp, pid) do
    Agent.update(pid, fn(map) -> Map.put(map, :exp, exp) end)
  end
  defp get_exp(pid) do
    Agent.get(pid, fn(map) -> Map.get(map, :exp) end)
  end
  defp stop_state(pid) do
    Agent.stop(pid)
  end
end
