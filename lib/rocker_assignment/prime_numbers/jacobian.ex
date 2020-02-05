defmodule RockerAssignment.CheckPrime.Jacobian do
  @moduledoc """
  Module for calculating Jacobian symbol a/n
  """

  def calculate(a, n) do
    cond do
      a == 0 -> 0
      n > a and Integer.mod(n, 2) == 1 ->
        pid = start_state(a, n)
        result = main_loop(pid)
        stop_state(pid)
        result
    end
  end

  defp main_loop(pid) do
    case a_get(pid) != 0 do
      true ->
        second_loop(pid)
      false ->
        if n_get(pid) == 1 do
          ans_get(pid)
        else
          0
        end
    end
  end

  defp second_loop(pid) do
    case Integer.mod(a_get(pid), 2) == 0 do
      true ->
        a_put(pid, div(a_get(pid), 2))
        r = Integer.mod(n_get(pid), 8)
        if r == 3 or r == 5 do
          ans_swap(pid)
        end
        second_loop(pid)
      false ->
        an_swap(pid, a_get(pid), n_get(pid))
        x = Integer.mod(a_get(pid), 4)
        y = Integer.mod(n_get(pid), 4)
        if x == y and y == 3 do
          ans_swap(pid)
        end
        a_put(pid, Integer.mod(a_get(pid), n_get(pid)))
        main_loop(pid)
    end
  end

  defp start_state(a, n) do
    {:ok, pid} = Agent.start_link(fn() -> %{ans: 1, a: a, n: n} end)
    pid
  end
  defp ans_swap(pid) do
    Agent.update(pid, fn(map) -> Map.put(map, :ans, -(map[:ans])) end)
  end
  defp ans_get(pid) do
    Agent.get(pid, fn(%{ans: ans}) -> ans end)
  end
  defp a_get(pid) do
    Agent.get(pid, fn(map) -> Map.get(map, :a) end)
  end
  defp a_put(pid, a) do
    Agent.update(pid, fn(map) -> Map.put(map, :a, a) end)
  end
  defp n_put(pid, n) do
    Agent.update(pid, fn(map) -> Map.put(map, :n, n) end)
  end
  defp n_get(pid) do
    Agent.get(pid, fn(map) -> Map.get(map, :n) end)
  end
  defp an_swap(pid, a, n) do
    a_put(pid, n)
    n_put(pid, a)
  end
  defp stop_state(pid) do
    Agent.stop(pid)
  end
end
