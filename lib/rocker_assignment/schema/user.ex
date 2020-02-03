defmodule RockerAssignment.Schema.User do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias RockerAssignment.Schema.User

  schema "users" do
    field  :uuid,  :string
    field  :name,  :string
    field  :email, :string
    field  :phone, :string

    timestamps()
    has_many :loans, RockerAssignment.Schema.Loan
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, ~w(name email phone)a)
    |> validate_required(~w(name email phone)a)
    |> unique_constraint(:name, name: :users_name_email_index)
    |> unique_constraint(:email, name: :users_name_email_index)
  end
end
