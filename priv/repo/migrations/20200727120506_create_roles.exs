defmodule PhoenixCms.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :role, :string, default: "user", null: "user"

      timestamps()
    end

  end
end
