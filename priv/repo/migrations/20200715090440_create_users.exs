defmodule PhoenixCms.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string, unique: true
      add :password_hash, :string
      add :role_id, references(:roles)

      timestamps()
    end

    create index(:users, [:role_id])

  end
end
