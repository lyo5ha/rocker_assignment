defmodule RockerAssignment.Utils.ErrorResolver do
  @moduledoc """
  Module for errors handling
  """

  def call(conn, %Ecto.Changeset{errors: errors_datails}) do
    error_list = Enum.map(errors_datails, fn(x) -> form_error(x) end)
    send_resp(conn, error_list)
  end

  def call(conn, {:message, message} = _params) do
    error_list = form_error({:error, {message, :filler}})
    send_resp(conn, error_list)
  end

  defp send_resp(conn, error_list) do
    json = Jason.encode!(%{jsonapi: %{version: "1.0"}, errors: error_list})
    conn
    |> Plug.Conn.put_resp_header("content-type", "application/json; charset=utf-8")
    |> Plug.Conn.send_resp(422, json)
  end

  defp form_error({attribute, {details, _}} = _params) do
    %{
        status: "422",
        source:  "/api/v1/loan/new",
        title:  "Invalid Attribute",
        detail: "#{attribute} #{details}"
      }
  end
end
