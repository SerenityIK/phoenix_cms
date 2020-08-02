defmodule PhoenixCms.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset

  alias PhoenixCms.Accounts.User

  schema "roles" do
    field :role, :string

    has_many :user, User

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:role])
    |> validate_required([:role])
  end
end
