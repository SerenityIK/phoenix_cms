defmodule PhoenixCms.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :text
      add :published, :boolean, default: false, null: false
      add :cover, :string
      add :slug, :string, unique: true
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

  end
end
