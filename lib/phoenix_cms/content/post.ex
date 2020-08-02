defmodule PhoenixCms.Content.Post do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset
  require Slugger

  alias PhoenixCms.Accounts.User
  alias PhoenixCmsWeb.Uploaders.Cover
  alias PhoenixCms.Content.Comment

  # @derive {Phoenix.Param, key: :slug}

  schema "posts" do
    field :body, :string
    field :published, :boolean, default: false
    field :slug, :string, unique: true
    field :title, :string
    field :cover, Cover.Type

    belongs_to :user, User
    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> common_changeset(attrs)
    |> validate_required([:user_id, :cover])
  end

  def common_changeset(changeset, attrs) do
    changeset
    |> cast(attrs, [:title, :body, :published, :user_id])
    |> cast_attachments(attrs, [:cover])
    |> validate_required([:title, :body])
    |> validate_length(:title, min: 3)
    |> trim_usafe_body(attrs)
    |> process_slug()
  end

  # Private functions

  defp process_slug(%Ecto.Changeset{valid?: validity, changes: %{title: title}} = changeset) do
    case validity do
      true -> put_change(changeset, :slug, Slugger.slugify_downcase(title))
      false -> changeset
    end
  end

  defp process_slug(changeset), do: changeset

  defp trim_usafe_body(changeset, %{"body" => body}) do
    {:safe, clean_body} = Phoenix.HTML.html_escape(body)
    changeset
    |> put_change(:body, clean_body)
  end

  defp trim_usafe_body(changeset, _), do: changeset

end
