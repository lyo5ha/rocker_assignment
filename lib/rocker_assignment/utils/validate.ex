defmodule RockerAssignment.Utils.Validate do
  @moduledoc """
  Validation of incoming params
  """
  import RockerAssignment.Utils.Debug

  @doc """
  Validate params and make


  """


  def params(params) do
    logger(params, "Incoming params from validate")

  end

  def params(_param) do
    {:error, }
  end
end
