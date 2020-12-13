defmodule PhoenixCms.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias PhoenixCms.Content.Post
  alias PhoenixCms.Content.Comment
  alias PhoenixCms.Accounts.Role


  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field(:password, :string, virtual: true)

    belongs_to :role, Role
    has_many :post, Post
    has_many :comments, Comment

    timestamps()
  end

  @create_fields ~w(name password email role_id)a

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @create_fields)
    |> validate_required(@create_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:name, min: 3)
    |> validate_length(:password, min: 8)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Argon2.hash_pwd_salt(pass))
      _ -> changeset
    end
  end

end
