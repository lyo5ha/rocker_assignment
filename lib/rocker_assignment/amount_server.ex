defmodule RockerAssignment.AmountServer do
  use GenServer

  # client

  def start_link(_params) do
    GenServer.start_link(__MODULE__, _params, name: {:global, :amount_server})
  end

  def put(pid, amount) do
    GenServer.cast(pid, {:put, amount})
  end

  def get(pid) do
    GenServer.call(pid, :get)
  end

  # server callbacks

  @impl true
  def init(map) do
    map = Map.put(map, :amount, 0)
    {:ok, map}
  end

  @impl true
  def handle_call(:get, _, map) do
    amount = Map.get(map, :amount)
    {:reply, amount, map}
  end

  @impl true
  def handle_cast({:put, amount}, map) do
    map = Map.put(map, :amount, amount)
    {:noreply, map}
  end
end
