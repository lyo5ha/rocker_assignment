defmodule RockerAssignment.Utils.ErrorResolver do
  @moduledoc """
  Module for errors handling
  """

  import RockerAssignment.Utils.Debug

  def call(conn, %Ecto.Changeset{errors: errors_datails}) do
    error_list = Enum.map(errors_datails, fn(x) -> form_error(x) end)
    json = Jason.encode!(%{jsonapi: %{version: "1.0"}, errors: error_list})
    conn
    |> Plug.Conn.put_resp_header("content-type", "application/json; charset=utf-8")
    |> Plug.Conn.send_resp(422, json)
  end

  defp form_error({attribute, {details, _}} = params) do
    logger(params, "form errors")
    error_info =
      %{
        "status": "422",
        "source":  "/api/v1/loan/new",
        "title":  "Invalid Attribute",
        "detail": "#{attribute} #{details}"
      }
  end
end
