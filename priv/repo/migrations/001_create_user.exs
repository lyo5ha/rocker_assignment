defmodule RockerAssignment.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do

      add  :name,       :string
      add  :email,      :string
      add  :phone,      :string

      timestamps()
    end

    create unique_index(:users, [:name, :email])
  end
end
