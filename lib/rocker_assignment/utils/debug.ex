defmodule RockerAssignment.Utils.Debug do
  @moduledoc :false
  require Logger

  def logger(something) do
    Logger.warn inspect(something, pretty: true)
    something
  end

  def logger(something, text) do
    Logger.warn("\n==============>>>>>>  #{text}  \n#{inspect(something, pretty: true)}")
    something
  end
end
