defmodule PhoenixCms.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :role, :string
      add :admin, :boolean, default: false, null: false

      timestamps()
    end

  end
end
