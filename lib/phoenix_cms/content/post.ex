defmodule PhoenixCms.Content.Post do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  require Slugger


  alias PhoenixCms.Content.User
  alias PhoenixCmsWeb.Uploaders.Cover


  schema "posts" do
    field :body, :string
    field :cover, :string
    field :published, :boolean, default: false
    field :slug, :string
    field :title, :string
    field :cover, Cover.Type

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> common_changeset(attrs)
    |> validate_required([:cover, :user_id])
  end

  def common_changeset(changeset, attrs) do
    changeset
    |> cast(attrs, [:title, :body, :published, :user_id])
    |> cast_attachments(attrs, [:cover])
    |> validate_required([:title, :body])
    |> validate_lenght(:title, min: 1)
    |> process_slug()
  end

  # Private functions
  defp process_slug(%Ecto.Changeset{valid?: validity, changes: %{title: title}} = changeset) do
    case validity do
      true -> put_change(changeset, :slug, Slugger.slugify_downcase(title))
      false -> changeset
    end
  end
end
