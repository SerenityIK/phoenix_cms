defmodule PhoenixCms.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :admin, :boolean, default: false
    field :role, :string

    has_many :users, PhoenixCms.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:role, :admin])
    |> validate_required([:role, :admin])
  end
end
