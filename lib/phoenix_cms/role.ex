defmodule PhoenixCms.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :is_admin, :boolean, default: false
    field :role, :string

    has_many :users, PhoenixCms.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:role, :is_admin])
    |> validate_required([:role, :is_admin])
  end
end
