defmodule PhoenixCms.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias PhoenixCms.Accounts.User
  alias PhoenixCms.Content.Post


  schema "comments" do
    field :approved, :boolean, default: false
    field :body, :string
    field :user_id, :id
    field :post_id, :id

    belongs_to :users, User
    belongs_to :posts, Post

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :approved])
    |> validate_required([:body, :approved])
  end
end
