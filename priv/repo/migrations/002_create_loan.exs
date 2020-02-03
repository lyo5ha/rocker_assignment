defmodule RockerAssignment.Repo.Migrations.CreateLoan do
  use Ecto.Migration

  def change do
    create table(:loans) do

      add  :status,     :string
      add  :amount,     :integer
      add  :rate,       :integer
      add  :user_id,    references(:users)

      timestamps()
    end
  end
end
