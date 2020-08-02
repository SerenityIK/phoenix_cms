defmodule PhoenixCms.Content.Comment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "comments" do
    field :approved, :boolean, default: false
    field :body, :string
    field :user_id, :id
    field :post_id, :id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs \\ %{}) do
    comment
    |> cast(attrs, [:body, :approved])
    |> validate_required([:body, :approved])
  end
end
